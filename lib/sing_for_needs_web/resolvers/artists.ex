defmodule SingForNeeds.Resolvers.Artist do
  @moduledoc false
  alias SingForNeeds.Artists

  def artists(_parent, _args, _resolution) do
    {:ok, Artists.list_artists()}
  end
end
