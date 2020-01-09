defmodule PlaceSmokey.MixProject do
  use Mix.Project

  def project do
    [
      app: :place_smokey,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:stash, :logger, :eex, :plug_cowboy, :mogrify],
      mod: {PlaceSmokey.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.1"},
      {:mogrify, "~> 0.7.3"},
      {:distillery, "~> 2.1"},
      {:stash, "~> 1.0.0"}
    ]
  end
end
