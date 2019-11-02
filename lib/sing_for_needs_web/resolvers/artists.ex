defmodule SingForNeedsWeb.Resolvers.Artist do
  @moduledoc false
  alias SingForNeeds.Artists

  def artists(_parent, _args, _resolution) do
    {:ok, Artists.list_artists()}
  end

  def create_artist(_parent, args, _resolution) do
    Artists.create_artist(args)
  end

  def update_artist(_parent, args, _resolution) do
    artist = Artists.get_artist(args[:artist_id])

    if artist do
      Artists.update_artist(artist, args)
    else
      {:error, "Record with id #{args[:artist_id]} missing in database"}
    end
  end
end
