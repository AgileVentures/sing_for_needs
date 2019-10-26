defmodule SingForNeedsWeb.Schema.Schema do
  @moduledoc """
    Uses GraphQL Absinthe schema to query resources from the database
  """
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(SingForNeedsWeb.Schema.{ArtistTypes, CauseTypes, PerformanceTypes})
  alias SingForNeedsWeb.Resolvers.{Artist, Cause, Performance}

  def dataloader do
    alias SingForNeeds.{Artists, Causes}

    Dataloader.new()
    |> Dataloader.add_source(Causes, Causes.datasource())
    |> Dataloader.add_source(Artists, Artists.datasource())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  query do
    @desc "get list of artists"
    field :artists, list_of(:artist) do
      resolve(&Artist.artists/3)
    end

    @desc "get list of all causes"
    field :causes, list_of(:cause) do
      resolve(&Cause.causes/3)
    end

    @desc "get list of all performances"
    field :performances, list_of(:performance) do
      resolve(&Performance.performances/3)
    end
  end

  mutation do
    @doc """
    create a cause
    """
    field :create_cause, :cause do
      arg(:description, non_null(:string))
      arg(:end_date, non_null(:date))
      arg(:start_date, non_null(:date))
      arg(:target_amount, non_null(:decimal))
      arg(:amount_raised, :decimal)
      arg(:sponsor, non_null(:string))
      arg(:name, non_null(:string))
      arg(:artists, list_of(:id))
      resolve(&Cause.create_cause/3)
    end

    @doc """
    create artists
    """
    field :create_artist, :artist do
      arg(:name, non_null(:string))
      arg(:bio, non_null(:string))
      arg(:causes, list_of(:id))
      resolve(&Artist.create_artist/3)
    end
  end
end
