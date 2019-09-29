defmodule SingForNeedsWeb.Schema.PerformanceTypes do
  @moduledoc """
  All types for Performance
  """
  use Absinthe.Schema.Notation

  object :performance do
    field :id, :id
    field :detail, :string
    field :amount_raised, :decimal
  end
end
