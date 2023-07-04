defmodule ExFleetYardsSSO.Repo do
  use Ecto.Repo,
    otp_app: :ex_fleet_yards_sso,
    adapter: Ecto.Adapters.Postgres
end
