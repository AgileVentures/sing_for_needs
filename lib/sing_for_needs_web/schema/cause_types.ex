defmodule SingForNeedsWeb.Schema.CauseTypes do
  @moduledoc """
  All types for causes
  """
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias SingForNeeds.Causes

  object :cause do
    field :id, :id
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :start_date, :date
    field :amount_raised, :decimal
    field :target_amount, :decimal
    field :sponsor, :string
    field :artists, list_of(:artist), resolve: dataloader(Causes)
  end
end
