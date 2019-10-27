defmodule SingForNeedsWeb.Resolvers.Cause do
  @moduledoc """
  Resolves for causes
  """
  import Absinthe.Resolution.Helpers, only: [on_load: 2]
  alias SingForNeeds.Causes

  @doc """
  Resolver function for getting a list of causes
  """
  def causes(_parent, args, _resolution) do
    if args == %{} do
      {:ok, Causes.list_causes()}
    else
      require IEx; IEx.pry
      {:ok, Causes.list_causes(args)}
    end
  end

  @doc """
  create_cause/3 creates a cause
  """
  def create_cause(_, args, _) do
    case Causes.create_cause_with_artists(args) do
      {:error, changeset} ->
        {:error, message: "Could not create cause", details: changeset}

      {:ok, cause} ->
        {:ok, cause}
    end
  end

  @doc """
  artist_for_cause/3 gets a list of artist for each cause
  """
  def artists_for_cause(cause, _, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load_many(Causes, :causes, cause)
    |> on_load(fn loader ->
      artists = Dataloader.get_many(loader, Causes, :artists, cause)
      {:ok, artists}
    end)
  end
end
