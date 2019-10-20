defmodule SingForNeeds.Artists.Artist do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Causes.Cause
  alias SingForNeeds.Performances.Performance

  schema "artists" do
    field :name, :string
    field :bio, :string
    many_to_many(:performances, Performance, join_through: "artists_performances", on_replace: :delete)
    many_to_many :causes, Cause, join_through: "artists_causes"
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
