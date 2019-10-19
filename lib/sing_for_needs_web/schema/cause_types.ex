defmodule SingForNeedsWeb.Schema.CauseTypes do
  @moduledoc """
  All types for causes
  """
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  object :cause do
    field :id, :id
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :start_date, :date
    field :amount_raised, :decimal
    field :target_amount, :decimal
    field :sponsor, :string
  end
end
