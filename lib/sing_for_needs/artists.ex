defmodule SingForNeeds.Artists do
  @moduledoc """
  The Artists context.
  """

  import Ecto.Query, warn: false
  alias SingForNeeds.Repo

  alias SingForNeeds.Artists.Artist

  @doc """
  Returns the list of artists.

  ## Examples

      iex> list_artists()
      [%Artist{}, ...]

  """
  def list_artists do
    Repo.all(Artist)
  end

  @doc """
  list_artists/1 filters artists by given filter criteria
  """
  def list_artists(criteria) do
    artists_query(criteria)
  end

  defp artists_query(criteria) do
    Enum.reduce(criteria, Artist, fn
      {:order, order}, query ->
        order_by(query, {^order, :name})
    end)
  end

  @doc """
  Gets a single artist.

  Raises `Ecto.NoResultsError` if the Artist does not exist.

  ## Examples

      iex> get_artist!(123)
      %Artist{}

      iex> get_artist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_artist!(id), do: Repo.get!(Artist, id)

  @doc """
  Get a single artist

  Does not raise an Ecto.NoResultsError if record is missing

  ## Examples 

  iex> get_artist(123)
    %Artist{}

  iex> get_artist(456)

  """

  def get_artist(id) do
    Repo.get(Artist, id)
  end

  @doc """
  Creates a artist.

  ## Examples

      iex> create_artist(%{field: value})
      {:ok, %Artist{}}

      iex> create_artist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_artist(attrs \\ %{}) do
    %Artist{}
    |> Artist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a artist.

  ## Examples

      iex> update_artist(artist, %{field: new_value})
      {:ok, %Artist{}}

      iex> update_artist(artist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_artist(%Artist{} = artist, attrs) do
    artist
    |> Artist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Artist.

  ## Examples

      iex> delete_artist(artist)
      {:ok, %Artist{}}

      iex> delete_artist(artist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_artist(%Artist{} = artist) do
    Repo.delete(artist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking artist changes.

  ## Examples

      iex> change_artist(artist)
      %Ecto.Changeset{source: %Artist{}}

  """
  def change_artist(%Artist{} = artist) do
    Artist.changeset(artist, %{})
  end

  @doc """
  Dataloader source
  """
  def datasource do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Artist, criteria) do
    artists_query(criteria)
  end

  def query(queryable, _) do
    queryable
  end
end
