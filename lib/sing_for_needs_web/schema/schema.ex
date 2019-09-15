defmodule SingForNeedsWeb.Schema.Schema do
    @moduledoc """
      Uses GraphQL Absinthe schema to query resources from the database
    """
    use Absinthe.Schema
    import_types SingForNeedsWeb.Schema.ArtistTypes
    alias SingForNeeds.Resolvers.Artist

  query do
    @desc "get list of artists"
    field :artists, list_of(:artist) do
      resolve &Artist.artists/3
    end
  end
end
