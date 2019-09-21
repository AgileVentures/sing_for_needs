defmodule SingForNeedsWeb.Schema.CauseTypes do
  @moduledoc """
  All types for causes
  """
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  object :cause do
    field :description, :string
    field :end_date, :naive_datetime
    field :name, :string
    field :start_date, :naive_datetime
    field :amount_raised, :decimal
    field :target_amount, :decimal
    field :sponsor, :string
  end
end
