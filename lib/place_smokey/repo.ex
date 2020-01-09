defmodule PlaceSmokey.Repo do
  alias PlaceSmokey.Image

  def all() do
    [
      %Image{
        id: 1,
        author: "usfsregion5",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/usfsregion5.jpg")
      },
      %Image{
        id: 2,
        author: "kumataro",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/kumataro.jpg")
      },
      %Image{
        id: 3,
        author: "kaibabnationalforest",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/kaibabnationalforest.jpg")
      },
      %Image{
        id: 4,
        author: "irvinglibrary",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/irvinglibrary.jpg")
      },
      %Image{
        id: 5,
        author: "azrainman",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/azrainman.jpg")
      },
      %Image{
        id: 6,
        author: "waynenf",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/waynenf.jpg")
      },
      %Image{
        id: 7,
        author: "upnorthmemories",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/upnorthmemories.jpg")
      },
      %Image{
        id: 8,
        author: "esywlkr",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/esywlkr.jpg")
      },
      %Image{
        id: 9,
        author: "gilaforest",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/gilaforest.jpg")
      },
      %Image{
        id: 10,
        author: "nasa2explore",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/nasa2explore.jpg")
      },
      %Image{
        id: 11,
        author: "upnorthmemories",
        path: Application.app_dir(:place_smokey, "priv/static/images/smokey/upnorthmemories-second.jpg")
      }
    ]
  end

  def get(id) when is_integer(id) do
    Enum.find(all(), fn(i) -> i.id == id end)
  end

end
