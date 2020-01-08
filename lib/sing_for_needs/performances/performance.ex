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
    field :performance_date, :date
    field :location, :string
    belongs_to :cause, Cause
    many_to_many(:artists, Artist, join_through: "artists_performances", on_replace: :delete)

    timestamps()
  end

  @doc """
  changeset to create performance
  """
  def changeset(performance, attrs) do
    performance =
      performance
      |> cast(attrs, [:title, :description, :image_url, :performance_date, :location])
      |> validate_required([:title, :description])

    if attrs[:artists] do
      performance = put_assoc(performance, :artists, attrs[:artists])
    else
      if attrs[:cause_id] do
        performance = build_cause_assoc(performance, attrs[:cause_id])
      else
        performance
      end
    end

    # cond attrs do
    #   %{artists: artists} = attrs ->
    #     put_assoc(performance, :artists, artists)

    #   %{cause_id: cause_id} = attrs ->
    #     build_cause_assoc(performance, cause_id)

    #   _ ->
    #     performance
    # end

    # performance
  end

  @doc """
    change set insert performance with artist (while creating the relationship)
  """

  defp build_cause_assoc(performance, cause_id) do
    cause = Causes.get_cause!(cause_id)
    Ecto.build_assoc(cause, :performances, performance)
  end

  defp put_artists_assoc(performance, artist_ids) do
    artists =
      Enum.map(artist_ids, fn artist_id ->
        Artists.get_artist(artist_id)
      end)

    Ecto.put_assoc(performance, artists)
  end
end
