defmodule SingForNeeds.Resolvers.Performance do
  @moduledoc """
  Resolves for performances
  """
  alias SingForNeeds.Performances

  @doc """
  performances/3 returns a list of all performances
  """
  def performances(_parent, _args, _resolution) do
    {:ok, Performances.list_performances()}
  end
end
