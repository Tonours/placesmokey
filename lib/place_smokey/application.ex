defmodule PlaceSmokey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start_link do
    port = Application.fetch_env!(:my_app, :port)
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [], port: port)
  end

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: PlaceSmokey.Worker.start_link(arg)
      # {PlaceSmokey.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: PlaceSmokey.Router, options: [port: 4000]}
    ]

    # Initalization of cache
    Stash.set(:my_cache, "foo", "bar")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlaceSmokey.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
