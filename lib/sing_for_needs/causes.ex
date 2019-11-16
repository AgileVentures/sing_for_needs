defmodule SingForNeeds.Causes do
  @moduledoc """
  The Causes context.
  """

  import Ecto.Query, warn: false
  use Timex
  alias SingForNeeds.Repo

  alias SingForNeeds.Causes.Cause

  @doc """
  Returns the list of causes.

  ## Examples

      iex> list_causes()
      [%Cause{}, ...]

  """
  def list_causes do
    Repo.all(from(c in Cause, preload: [:artists], select: c))
  end

  @doc """
  list_causes/1 returns a list of cause based on some given
  criteria(passed as a map)
  Returns an empty array if there is no cause

  ## Parameters
  criteria - A map of criteria

  ## Examples
  iex> Causes.list_causes(%{ order: :desc})
  [%Cause{}, %Cause{}]
  iex> Causes.list_causes(%{ order: :desc})
  []

  """
  def list_causes(criteria) do
    criteria
    |> causes_query
    |> Repo.all()
  end

  defp causes_query(criteria) do
    query = from c in Cause, select: c
    Enum.reduce(criteria, query, &compose_query/2)
  end

  defp compose_query({:scope, "trending"}, query) do
    from c in query,
      preload: [:artists],
      left_join: a in assoc(c, :artists),
      order_by: [desc: :amount_raised, desc: count(a.id)],
      group_by: c.id
  end

  defp compose_query({:scope, "ending_soon"}, query) do
    from c in query,
      preload: [:artists],
      where: c.end_date > ^Timex.now(),
      order_by: [asc: c.end_date]
  end

  defp compose_query({:limit, limit}, query) do
    limit(query, ^limit)
  end

  @doc """
  Gets a single cause.

  Raises `Ecto.NoResultsError` if the Cause does not exist.

  ## Examples

      iex> get_cause!(123)
      %Cause{}

      iex> get_cause!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cause!(id) do
    Cause
    |> preload(:artists)
    |> Repo.get!(id)
  end

  @doc """
  Creates a cause.

  ## Examples

      iex> create_cause(%{field: value})
      {:ok, %Cause{}}

      iex> create_cause(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cause(attrs \\ %{}) do
    %Cause{}
    |> Cause.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  create_cause_with_artists/1 creates a cause with many artists
  """
  def create_cause_with_artists(attrs \\ %{}) do
    cause =
      %Cause{}
      |> Cause.changeset_for_many_artists(attrs)
      |> Repo.insert()

    cause
  end

  @doc """
  Updates a cause.

  ## Examples

      iex> update_cause(cause, %{field: new_value})
      {:ok, %Cause{}}

      iex> update_cause(cause, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cause(%Cause{} = cause, attrs) do
    cause
    |> Cause.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Cause.

  ## Examples

      iex> delete_cause(cause)
      {:ok, %Cause{}}

      iex> delete_cause(cause)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cause(%Cause{} = cause) do
    Repo.delete(cause)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cause changes.

  ## Examples

      iex> change_cause(cause)
      %Ecto.Changeset{source: %Cause{}}

  """
  def change_cause(%Cause{} = cause) do
    Cause.changeset(cause, %{})
  end

  @doc """
  Dataloader
  """
  def datasource do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(Cause, criteria) do
    causes_query(criteria)
  end

  def query(queryable, _) do
    queryable
  end
end
