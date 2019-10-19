defmodule SingForNeedsWeb.Schema.ArtistTypes do
    @moduledoc """
    All types for artists
    """
    use Absinthe.Schema.Notation
    import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

    object :artist do
      field :id, :id
      field :name, :string
      field :causes, list_of(:cause), resolve: dataloader(Causes)
    end

    def dataloader do
      alias SingForNeeds.{Artists, Causes}
      loader = Dataloader.new
      |> Dataloader.add_source(Causes, Causes.datasource())
      |> Dataloader.add_source(Artists, Artists.datasource())
    end

    def context(ctx) do
      Map.put(ctx, :loader, dataloader)
    end

    def plugins do
      [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
    end
end
