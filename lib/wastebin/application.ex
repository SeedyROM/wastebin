defmodule Wastebin.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Wastebin.Repo,
      {Plug.Cowboy, scheme: :http, plug: Wastebin.Plugs.API, options: [port: 8080]},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wastebin.Supervisor]

    Logger.info("Starting application...")
    Supervisor.start_link(children, opts)
  end
end
