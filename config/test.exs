import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ex_fleet_yards_sso, ExFleetYardsSSO.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "ex_fleet_yards_sso_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_fleet_yards_sso_web, ExFleetYardsSSOWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "EoSlKStd3DFNWz3df2yC5fhB/zzc9WrvIcwDXP4451i+07N+e/9Sxx0EgphnRpYw",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# In test we don't send emails.
config :ex_fleet_yards_sso, ExFleetYardsSSO.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
