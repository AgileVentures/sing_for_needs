defmodule SingForNeedsWeb.Schema.Schema do
    @moduledoc false
    use Absinthe.Schema

  query do
    @desc "get list of artists"
    field :artists, list_of(:artist) do
      resolve &SingForNeeds.Resolvers.Artist.artists/3
    end    
  end

  object :artist do
    field :id, :id
    field :name, :string
  end
end
