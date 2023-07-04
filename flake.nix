{
  description = "Fleetyards SSO service";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "/nixpkgs";
      inputs.flake-compat.follows = "/flake-compat";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, devenv, ... }:
    let
      version = "${nixpkgs.lib.substring 0 8 self.lastModifiedDate}-${
          self.shortRev or "dirty"
        }";

      systems =
        [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);

      # Memoize nixpkgs for different platforms
      nixpkgsFor = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        });
    in {
      overlays.fleet = final: prev: {
        fleetyards_sso = final.callPackage
          ({ lib, beam, rebar3, beamPackages, writeText }:
            let
              packages = beam.packagesWith beam.interpreters.erlang;
              pname = "ex_fleet_yards_sso";
              src = self;
              mixEnv = "prod";

              mixDeps = import ./nix/mix.nix {
                inherit lib beamPackages;
                overrides = overrideDeps;
              };

              overrideDeps = (self: super: { });
            in packages.mixRelease {
              inherit pname version src mixEnv;

              mixNixDeps = mixDeps;

              FLEETYARDS_GIT_COMMIT = version;

              nativeBuildInputs = [ rebar3 ];
            }) { };
      };
      overlays.default = self.overlays.fleet;

      packages = forAllSystems (system: {
        inherit (nixpkgsFor.${system}) fleetyards_sso;
        default = self.packages.${system}.fleetyards_sso;
      });

      legacyPackages = nixpkgsFor;

      devShells = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          elixir = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              ({ pkgs, ... }: {
                packages = with pkgs;
                  [ mix2nix git gnumake gcc ]
                  ++ lib.optional pkgs.stdenv.isLinux pkgs.inotify-tools;

                languages.elixir.enable = true;

                pre-commit.hooks.actionlint.enable = true;
                pre-commit.hooks.nixfmt.enable = true;

              })
              {
                env.FLEETYARDS_IN_DEVENV = 1;
                env.FLEETYARDS_GIT_COMMIT = "devenv-version-dirty";
                services.postgres.enable = true;
                services.postgres.listen_addresses = "127.0.0.1";
                services.postgres.initialDatabases =
                  [{ name = "fleet_yards_dev"; }];
                process.implementation = "hivemind";
              }
            ];
          };
          default = self.devShells.${system}.elixir;
        });

      formatter = forAllSystems (system: nixpkgsFor.${system}.nixfmt);

      checks = forAllSystems
        (system: { devenv = self.devShells.${system}.elixir.ci; });
    };

  nixConfig = {
    extra-substituters = [ "https://fleetyards.cachix.org" ];
    extra-trusted-public-keys = [
      "fleetyards.cachix.org-1:forDt7WbrGA2J1Vv8qCdTDPeqORfKX5KiHdZ0daRwm8="
    ];
  };
}
