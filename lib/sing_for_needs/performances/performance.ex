defmodule SingForNeeds.Performances.Performance do
  @moduledoc """
      A Perfomance
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Artists.Artist
  alias SingForNeeds.Causes
  alias SingForNeeds.Causes.Cause

  schema "performances" do
    field :title, :string
    field :description, :string
    field :image_url, :string
    belongs_to :cause, Cause
    many_to_many(:artists, Artist, join_through: "artists_performances", on_replace: :delete)

    timestamps()
  end

  @doc """
  changeset to create performance
  """
  def changeset(performance, attrs) do
    performance
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])

    case attrs do
      %{artists: artists} = attrs ->
        performance
        |> put_assoc(:artists, artists)

      %{cause_id: cause_id} = attrs ->
        performance
        |> build_cause_assoc(cause_id)

      _ ->
        performance
    end

    performance
  end

  @doc """
    change set insert performance with artist (while creating the relationship)
  """
  def changeset_update_artists(performance, attrs) do
    performance
    |> cast(attrs, [:title, :description])
    |> put_assoc(:artists, attrs.artists)
  end

  defp build_cause_assoc(performance, cause_id) do
    cause = Causes.get_cause(cause_id)

    performance
    |> Ecto.build_assoc(cause, :performances)
  end

  defp put_artists_assoc(performance, artist_ids) do
    artists =
      Enum.map(artist_ids, fn artist_id ->
        Artists.get_artist(artist_id)
      end)

    performance
    |> Ecto.put_assoc(artists)
  end
end
