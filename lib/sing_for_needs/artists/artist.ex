defmodule SingForNeeds.Artists.Artist do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Causes
  alias SingForNeeds.Causes.Cause
  alias SingForNeeds.Performances.Performance

  schema "artists" do
    field :name, :string
    field :bio, :string

    many_to_many(:performances, Performance,
      join_through: "artists_performances",
      on_replace: :delete
    )

    many_to_many :causes, Cause, join_through: "artists_causes"
    timestamps()
  end

  @doc false
  def changeset(artist, attrs) do
    artist =
      artist
      |> cast(attrs, [:name, :bio])
      |> validate_required([:name, :bio])
      |> associate_artist_to_causes(attrs)
  end

  defp associate_artist_to_causes(artist, attrs) do
    case attrs do
      %{causes: causes} ->
        artist =
          Ecto.Changeset.put_assoc(
            artist,
            :causes,
            Enum.map(causes, fn cause_id -> Causes.get_cause!(cause_id) end)
          )

      _ ->
        artist
    end
  end
end
