defmodule SingForNeeds.Causes do
  @moduledoc """
  The Causes context.
  """

  import Ecto.Query, warn: false
  alias SingForNeeds.Repo

  alias SingForNeeds.Causes.Cause

  @doc """
  Returns the list of causes.

  ## Examples

      iex> list_causes()
      [%Cause{}, ...]

  """
  def list_causes do
    Repo.all(Cause)
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
  def get_cause!(id), do: Repo.get!(Cause, id)

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
    %Cause{}
    |> Cause.changeset_for_many_artists(attrs)
    |> Repo.insert()
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
    # require IEx; IEx.pry
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
end
