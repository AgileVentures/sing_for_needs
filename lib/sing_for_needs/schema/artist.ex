defmodule SingForNeeds.Schema.Artist do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :bio, :string
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
