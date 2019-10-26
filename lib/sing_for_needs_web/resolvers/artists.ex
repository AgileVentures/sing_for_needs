defmodule SingForNeedsWeb.Resolvers.Artist do
  @moduledoc false
  alias SingForNeeds.Artists
  import Absinthe.Resolution.Helpers, only: [on_load: 2]

  def artists(_parent, _args, _resolution) do
    {:ok, Artists.list_artists()}
  end
end
