defmodule SingForNeedsWeb.Schema.ArtistTypes do
  @moduledoc """
  All types for artists
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias SingForNeeds.Causes

  object :artist do
    field :id, :id
    field :name, :string
    field :causes, list_of(:cause), resolve: dataloader(Causes)
  end
end
