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

  @doc """
  create_cause/3 creates a cause
  """
  def create_cause(_, args, _) do
    case Causes.create_cause(args) do
      {:error, changeset} ->
        {:error, message: "Could not create cause", details: changeset}
      {:ok, cause} ->
        {:ok, cause}
    end
  end
end
