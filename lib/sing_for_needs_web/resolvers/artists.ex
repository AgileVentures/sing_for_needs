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
    {:ok, Artists.update_artist(args)}
  end
end
