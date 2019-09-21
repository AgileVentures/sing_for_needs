defmodule SingForNeeds.Resolvers.Cause do
  @moduledoc """
  Resolves for causes
  """
  alias SingForNeeds.Causes

  @doc """
  Resolver function for getting a list of causes
  """
  def causes(_parent, _args, _resolution) do
    {:ok, Causes.list_causes()}
  end
end
