defmodule SingForNeeds.Artists.Artist do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string
    field :about, :string
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name, :about])
    |> validate_required([:name, :about])
  end
end
