defmodule SingForNeedsWeb.Schema.ArtistTypes do
    @moduledoc """
    All types for artists
    """
    use Absinthe.Schema.Notation
    object :artist do
      field :id, :id
      field :name, :string
    end
end
