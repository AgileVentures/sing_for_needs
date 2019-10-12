defmodule SingForNeeds.Resolvers.Artist do
  @moduledoc false
  alias SingForNeeds.Artists
  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def artists(_parent, _args, _resolution) do
    {:ok, Artists.list_artists()}
  end

  def artists_for_cause(cause, criteria, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load_many(Artists, {:artists, criteria}, cause)
    |> on_load(fn loader ->
        artists = Dataloader.get_many(loader, Artists, {:artists, criteria}, cause)
        {:ok, artists}
      end)
  end
end
