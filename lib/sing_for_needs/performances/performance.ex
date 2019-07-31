defmodule SingForNeeds.Performances.Perfomance do
@moduledoc """
    A Perfomance
"""
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Artists
  schema "performances" do
    field :name, :string
    field :detail, :string
    field :amount_raised, :float
    has_many :artists, Artist

    timestamps()
  end

  @doc false
  def changeset(performance, attrs) do
    performance
    |> cast(attrs, [:name, :detail, :amount_raised, :artist_id ])
    |> validate_required([:name, :detail])
  end
end
