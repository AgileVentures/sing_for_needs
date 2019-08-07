defmodule SingForNeeds.Performances.Performance do
@moduledoc """
    A Perfomance
"""
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Artists.Artist

  schema "performances" do
    field :name, :string
    field :detail, :string
    field :amount_raised, :float
    many_to_many(:artists, Artist , join_through: :artists_performances, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(performance, attrs) do
    performance
    |> cast(attrs, [:name, :detail, :amount_raised, :artist_id ])
    |> validate_required([:name, :detail])
  end

  @doc """
    insert performance with artist
  """
  def changeset_update_artists(performance, artists) do
    performance
    |> cast(%{}, [:name, :detail ])
    |> put_assoc(:artists, artists)
  end
end
