defmodule ExFleetYardsSSO.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExFleetYardsSSO.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExFleetYardsSSO.PubSub},
      # Start Finch
      {Finch, name: ExFleetYardsSSO.Finch}
      # Start a worker by calling: ExFleetYardsSSO.Worker.start_link(arg)
      # {ExFleetYardsSSO.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ExFleetYardsSSO.Supervisor)
  end
end
