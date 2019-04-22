defmodule SingForNeeds.Artists.Artist do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
