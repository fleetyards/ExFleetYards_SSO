{ lib, beamPackages, overrides ? (x: y: { }) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages;
    with self; {
      bunt = buildMix rec {
        name = "bunt";
        version = "0.2.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "19bp6xh052ql3ha0v3r8999cvja5d2p6cph02mxphfaj4jsbyc53";
        };

        beamDeps = [ ];
      };

      castore = buildMix rec {
        name = "castore";
        version = "1.0.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "02rrljx2f6zhmiwqwyk7al0gdf66qpx4jm59sqg1cnyiylgb02k8";
        };

        beamDeps = [ ];
      };

      cowboy = buildErlangMk rec {
        name = "cowboy";
        version = "2.10.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0sqxqjdykxc2ai9cvkc0xjwkvr80z98wzlqlrd1z3iiw32vwrz9s";
        };

        beamDeps = [ cowlib ranch ];
      };

      cowboy_telemetry = buildRebar3 rec {
        name = "cowboy_telemetry";
        version = "0.4.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1pn90is3k9dq64wbijvzkqb6ldfqvwiqi7ymc8dx6ra5xv0vm63x";
        };

        beamDeps = [ cowboy telemetry ];
      };

      cowlib = buildRebar3 rec {
        name = "cowlib";
        version = "2.12.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1c4dgi8canscyjgddp22mjc69znvwy44wk3r7jrl2wvs6vv76fqn";
        };

        beamDeps = [ ];
      };

      credo = buildMix rec {
        name = "credo";
        version = "1.7.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1mv9lyw6hgjn6hlnzfbs0x2dchvwlmj8bg0a8l7iq38z7pvgqfb8";
        };

        beamDeps = [ bunt file_system jason ];
      };

      db_connection = buildMix rec {
        name = "db_connection";
        version = "2.5.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "18jsnmabdjwj3i7ml43ljzrzzvfy1a3bnbaqywgsv7nndji5nbf9";
        };

        beamDeps = [ telemetry ];
      };

      decimal = buildMix rec {
        name = "decimal";
        version = "2.1.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1k7z418b6cj977wswpxsk5844xrxc1smaiqsmrqpf3pdjzsfbksk";
        };

        beamDeps = [ ];
      };

      earmark_parser = buildMix rec {
        name = "earmark_parser";
        version = "1.4.33";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "13qvlqnii8g6bcz6cl330vjwaan7jy30g1app3yvjncvf8rnhlid";
        };

        beamDeps = [ ];
      };

      ecto = buildMix rec {
        name = "ecto";
        version = "3.10.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0d82qqlvhpi1mkqifayzzd0r0068l5csz1ml6i5qlr6py1w5g2ba";
        };

        beamDeps = [ decimal jason telemetry ];
      };

      ecto_sql = buildMix rec {
        name = "ecto_sql";
        version = "3.10.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0sy5277akp828hvcg60yxhpfgj543y2z1bqy2z414pv9ppdmp8pn";
        };

        beamDeps = [ db_connection ecto postgrex telemetry ];
      };

      esbuild = buildMix rec {
        name = "esbuild";
        version = "0.7.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0g7i36fsnry20w15lq5jc6bval3pwv73ymqnvkj8wdxif3giqrk6";
        };

        beamDeps = [ castore ];
      };

      ex_doc = buildMix rec {
        name = "ex_doc";
        version = "0.29.4";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1xf49d0ni08a83iankdj8fb6jyxm67wjl0gdwihwnimf6ykrjric";
        };

        beamDeps = [ earmark_parser makeup_elixir makeup_erlang ];
      };

      expo = buildMix rec {
        name = "expo";
        version = "0.4.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0iyfl4vppfhmimfqaracjza9a6y8rgia03sm28y5934cg5xbmxrg";
        };

        beamDeps = [ ];
      };

      file_system = buildMix rec {
        name = "file_system";
        version = "0.2.10";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1p0myxmnjjds8bbg69dd6fvhk8q3n7lb78zd4qvmjajnzgdmw6a1";
        };

        beamDeps = [ ];
      };

      finch = buildMix rec {
        name = "finch";
        version = "0.16.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1iayffbjzb1rcy1p0wibzv6j5n7dc16ha5lhcbn5z7ji9m61fq7n";
        };

        beamDeps = [ castore mime mint nimble_options nimble_pool telemetry ];
      };

      floki = buildMix rec {
        name = "floki";
        version = "0.34.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0h936kfai562dh4qpcpri7jxrdmqyxaymizk9d5r55svx8748xwm";
        };

        beamDeps = [ ];
      };

      gettext = buildMix rec {
        name = "gettext";
        version = "0.22.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1gb49f75apkgfa5ddg02x08w1i3qm31jifzicrl4m58kfx226pwk";
        };

        beamDeps = [ expo ];
      };

      hpax = buildMix rec {
        name = "hpax";
        version = "0.1.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "04wci9ifsfyd2pbcrnpgh2aq0a8fi1lpkrzb91kz3x93b8yq91rc";
        };

        beamDeps = [ ];
      };

      jason = buildMix rec {
        name = "jason";
        version = "1.4.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0891p2yrg3ri04p302cxfww3fi16pvvw1kh4r91zg85jhl87k8vr";
        };

        beamDeps = [ decimal ];
      };

      makeup = buildMix rec {
        name = "makeup";
        version = "1.1.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "19jpprryixi452jwhws3bbks6ki3wni9kgzah3srg22a3x8fsi8a";
        };

        beamDeps = [ nimble_parsec ];
      };

      makeup_elixir = buildMix rec {
        name = "makeup_elixir";
        version = "0.16.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1ik7qw0d5xyc7dv3n33qxl49jfk92l565lbv1zc9n80vmm0s69z1";
        };

        beamDeps = [ makeup nimble_parsec ];
      };

      makeup_erlang = buildMix rec {
        name = "makeup_erlang";
        version = "0.1.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "02411riqa713wzw8in582yva6n6spi4w1ndnj8nhjvnfjg5a3xgk";
        };

        beamDeps = [ makeup ];
      };

      mime = buildMix rec {
        name = "mime";
        version = "2.0.5";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0p50h0ki8ay5sraiqxiajgwy1829bvyagj65bj9wjny4cnin83fs";
        };

        beamDeps = [ ];
      };

      mint = buildMix rec {
        name = "mint";
        version = "1.5.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "07jvgmggmv6bxhkmrskdjz1xvv0a1l53fby7sammcfbwdbky2qsa";
        };

        beamDeps = [ castore hpax ];
      };

      nimble_options = buildMix rec {
        name = "nimble_options";
        version = "1.0.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1f7ih1rnkvph0daf4lsv4rrp6dpccksjd7rh5bhnq0r143dsh4px";
        };

        beamDeps = [ ];
      };

      nimble_parsec = buildMix rec {
        name = "nimble_parsec";
        version = "1.3.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0rxiw6jzz77v0j460wmzcprhdgn71g1hrz3mcc6djn7bnb0f70i6";
        };

        beamDeps = [ ];
      };

      nimble_pool = buildMix rec {
        name = "nimble_pool";
        version = "1.0.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0ymn22kj8jkyx1xjh2ldz65s4lhr3f70g1v04n11hd9d5n43pgl0";
        };

        beamDeps = [ ];
      };

      phoenix = buildMix rec {
        name = "phoenix";
        version = "1.7.6";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "127v5lrb0zflgm5cqwxsfjv76mizdldkzs66rdhb0as0h1vvxd7n";
        };

        beamDeps = [
          castore
          jason
          phoenix_pubsub
          phoenix_template
          plug
          plug_cowboy
          plug_crypto
          telemetry
          websock_adapter
        ];
      };

      phoenix_ecto = buildMix rec {
        name = "phoenix_ecto";
        version = "4.4.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0pcgrvj5lqjmsngrhl77kv0l8ik8gg7pw19v4xlhpm818vfjw93h";
        };

        beamDeps = [ ecto phoenix_html plug ];
      };

      phoenix_html = buildMix rec {
        name = "phoenix_html";
        version = "3.3.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1lyhagjpg4lran6431csgkvf28g50mdvh4mlsxgs21j9vmp91ldy";
        };

        beamDeps = [ plug ];
      };

      phoenix_live_dashboard = buildMix rec {
        name = "phoenix_live_dashboard";
        version = "0.8.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "03a1rmjsz25mk38c1ls95qna9cby150sf9qjgak93vag8xa5ly47";
        };

        beamDeps = [ ecto mime phoenix_live_view telemetry_metrics ];
      };

      phoenix_live_reload = buildMix rec {
        name = "phoenix_live_reload";
        version = "1.4.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1aqm6sxy4ijd5gi8lmjmcaxal1smg2smibjlzrkq9w6xwwsbizwv";
        };

        beamDeps = [ file_system phoenix ];
      };

      phoenix_live_view = buildMix rec {
        name = "phoenix_live_view";
        version = "0.19.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "003yvnhjxdf4s9cf2qqm4b29vbvspmskpn13xbc5yja8g642cmjl";
        };

        beamDeps = [ jason phoenix phoenix_html phoenix_template telemetry ];
      };

      phoenix_pubsub = buildMix rec {
        name = "phoenix_pubsub";
        version = "2.1.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "00p5dvizhawhqbia2cakdn4whaxsm2adq3lzfn3b137xvk0np85v";
        };

        beamDeps = [ ];
      };

      phoenix_template = buildMix rec {
        name = "phoenix_template";
        version = "1.0.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1vlkd4z2bxinczwcysydidpnh49rpxjihb5k3k4k8qr2yrwc0z8m";
        };

        beamDeps = [ phoenix_html ];
      };

      plug = buildMix rec {
        name = "plug";
        version = "1.14.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "04wdyv6nma74bj1m49vkm2bc5mjf8zclfg957fng8g71hw0wabw4";
        };

        beamDeps = [ mime plug_crypto telemetry ];
      };

      plug_cowboy = buildMix rec {
        name = "plug_cowboy";
        version = "2.6.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "04v6xc4v741dr2y38j66fmcc4xc037dnaxzkj2vih6j53yif2dny";
        };

        beamDeps = [ cowboy cowboy_telemetry plug ];
      };

      plug_crypto = buildMix rec {
        name = "plug_crypto";
        version = "1.2.5";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0hnqgzc3zas7j7wycgnkkdhaji5farkqccy2n4p1gqj5ccfrlm16";
        };

        beamDeps = [ ];
      };

      postgrex = buildMix rec {
        name = "postgrex";
        version = "0.17.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0md5j9k1vkwwzql68in6hmj0vfcdbnav33shxszf4fz7i2s5gc0l";
        };

        beamDeps = [ db_connection decimal jason ];
      };

      ranch = buildRebar3 rec {
        name = "ranch";
        version = "1.8.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1rfz5ld54pkd2w25jadyznia2vb7aw9bclck21fizargd39wzys9";
        };

        beamDeps = [ ];
      };

      swoosh = buildMix rec {
        name = "swoosh";
        version = "1.11.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0vkjz91jbymbxyp3z8ha6i6iqvf0qy5ay5430azxbrq32mcz8hsc";
        };

        beamDeps = [ cowboy finch jason mime plug_cowboy telemetry ];
      };

      tailwind = buildMix rec {
        name = "tailwind";
        version = "0.2.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0xx2r741jzh669229nni7h4mmsz18hbj5d6iivjp6py90xhkz8g8";
        };

        beamDeps = [ castore ];
      };

      telemetry = buildRebar3 rec {
        name = "telemetry";
        version = "1.2.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1mgyx9zw92g6w8fp9pblm3b0bghwxwwcbslrixq23ipzisfwxnfs";
        };

        beamDeps = [ ];
      };

      telemetry_metrics = buildMix rec {
        name = "telemetry_metrics";
        version = "0.6.1";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "1iilk2n75kn9i95fdp8mpxvn3rcn3ghln7p77cijqws13j3y1sbv";
        };

        beamDeps = [ telemetry ];
      };

      telemetry_poller = buildRebar3 rec {
        name = "telemetry_poller";
        version = "1.0.0";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0vjgxkxn9ll1gc6xd8jh4b0ldmg9l7fsfg7w63d44gvcssplx8mk";
        };

        beamDeps = [ telemetry ];
      };

      websock = buildMix rec {
        name = "websock";
        version = "0.5.2";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "01gzcvz86x4hxk5d50qz38nkmi1fakyn5yw0m7gi6s6a5zi5spwj";
        };

        beamDeps = [ ];
      };

      websock_adapter = buildMix rec {
        name = "websock_adapter";
        version = "0.5.3";

        src = fetchHex {
          pkg = "${name}";
          version = "${version}";
          sha256 = "0g8djd6l1yq8s84y4r3938dczvjs6jgxjbdm0ah6wszqq4abirfb";
        };

        beamDeps = [ plug plug_cowboy websock ];
      };
    };
in self

