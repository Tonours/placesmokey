defmodule PlaceSmokey.Router do
  alias PlaceSmokey.Image

  use Plug.Router

  plug(Plug.Logger)
  plug Plug.Static,
    at: "/",
    from: :place_smokey,
    only: ~w(css fonts images js favicon.ico favicon robots.txt)
  plug :match
  plug :dispatch

  get "/" do
    render(conn, "index")
  end

  get "/g/:width/*height" do
    case Image.get(%{width: width, height: List.first(height)}, true) do
      {:ok, image } -> send_file(conn, 200, image.path)
    end
  end

  get "/:width/*height" do
    case Image.get(%{width: width, height: List.first(height)}) do
      {:ok, image } ->
        conn
          |> put_resp_content_type("image/jpeg")
          |> put_resp_header("content-disposition", "filename=smokey#{image.ext}")
          |> send_file(200, image.path)
    end
  end

  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      Application.app_dir(:place_smokey, "priv/templates")
      |> Path.join(template <> ".html.eex")
      |> EEx.eval_file(assigns)

    conn
    |> put_resp_content_type("text/html")
    |> send_resp((status || 200), body)
  end
end
