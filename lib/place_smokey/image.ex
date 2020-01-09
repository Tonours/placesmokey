defmodule PlaceSmokey.Image do
  import Mogrify
  use Mogrify.Options

  alias PlaceSmokey.Repo

  defstruct id: nil, author: "", path: ""

  def get(dimension, gray \\ false) do
    %{width: width, height: height} = dimension

    height = height || width

    width = case Integer.parse(width) do
      {width, ""} when width > 0 and width <= 1000 ->
        width
      {_width, ""} ->
        1000
      _ -> 100
    end

    height = case Integer.parse(height) do
      {height, ""} when height > 0 and height <= 1000 ->
        height
      {_height, ""} ->
        1000
      _ -> 100
    end

    size = get_size(width, height)
    random_image = get_random_image()

    {:ok, get_image_cached(random_image, size, gray)}
  end

  defp crop(image, size) do
    caching_key = get_caching_key(size, false)
    image =
      open(image.path)
        |> resize_to_fill(size)
        |> gravity("center")
        |> save()
    Stash.set(:my_cache, caching_key, image)
    image
  end

  defp crop(image, size, gray) do
    caching_key = get_caching_key(size, gray)

    image =
      open(image.path)
        |> resize_to_fill(size)
        |> gravity("center")
        |> custom("-type", "Grayscale")
        |> save()
    Stash.set(:my_cache, caching_key, image)
    image
  end

  defp get_image_cached(image, size, gray) when gray == true do
    caching_key = get_caching_key(size, gray)
    image_cache = Stash.get(:my_cache, caching_key)

    if image_cache do
      image_cache
    else
      crop(image, size, gray)
    end
  end

  defp get_image_cached(image, size, _false) do
    caching_key = get_caching_key(size, false)
    image_cache = Stash.get(:my_cache, caching_key)

    if image_cache do
      image_cache
    else
      crop(image, size)
    end
  end

  defp get_caching_key(size, gray) do
    if gray do
      "#{size}#g"
    else
      "#{size}"
    end
  end

  defp get_size(width, height) do
    "#{width}" <> "x" <> "#{height}"
  end

  defp get_random_image do
    number =
      1..Kernel.length(Repo.all())
      |> Enum.to_list
      |> Enum.random

    Repo.get(number)
  end

end
