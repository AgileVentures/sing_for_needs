defmodule SingForNeedsWeb.Schema.Schema do
  @moduledoc """
    Uses GraphQL Absinthe schema to query resources from the database
  """
  use Absinthe.Schema
  import_types(SingForNeedsWeb.Schema.{ArtistTypes, CauseTypes})
  alias SingForNeeds.Resolvers.{Artist, Cause}

  query do
    @desc "get list of artists"
    field :artists, list_of(:artist) do
      resolve(&Artist.artists/3)
    end

    @desc "get list of all causes"
    field :causes, list_of(:cause) do
      resolve(&Cause.causes/3)
    end
  end

  mutation do
    @doc """
    create a cause
    """
    field :create_cause, :cause do
      arg :description, non_null(:string)
      arg :end_date, non_null(:date)
      arg :start_date, non_null(:date)
      arg :target_amount, non_null(:decimal)
      arg :amount_raised, :decimal
      arg :sponsor, non_null(:string)
      arg :name, non_null(:string)
      resolve &Cause.create_cause/3
    end
  end
end
