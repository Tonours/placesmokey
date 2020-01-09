defmodule Mix.Tasks.PlaceSmokey.Server do
  use Mix.Task
  require Logger

  def run(args \\ []) do
    Logger.info("Starting server")
    Mix.Tasks.Run.run(args ++ ["--no-halt"])
  end
end
