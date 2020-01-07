defmodule SingForNeedsWeb.Schema.PerformanceTypes do
  @moduledoc """
  All types for Performance
  """
  use Absinthe.Schema.Notation

  object :performance do
    field :id, :id
    field :description, :string
    field :performance_date, :date
    field :title, :string
    field :image_url, :string
    field :location, :string
  end
end
