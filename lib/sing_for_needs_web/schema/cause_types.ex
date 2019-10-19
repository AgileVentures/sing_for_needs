defmodule SingForNeedsWeb.Schema.CauseTypes do
  @moduledoc """
  All types for causes
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias SingForNeeds.Resolvers.Artist

  object :cause do
    field :id, :id
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :start_date, :date
    field :amount_raised, :decimal
    field :target_amount, :decimal
    field :sponsor, :string
    field :artists, list_of(:artist), resolve: dataloader(Artists)
  end

  def dataloader do
    alias SingForNeeds.{Artists, Causes}
    loader = Dataloader.new
    |> Dataloader.add_source(Causes, Causes.datasource())
    |> Dataloader.add_source(Artists, Artists.datasource())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
