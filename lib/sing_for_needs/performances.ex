defmodule SingForNeeds.Performances do
  @moduledoc """
     Context for the performance schema
  """
  alias SingForNeeds.Performances.Performance
  alias SingForNeeds.Repo

  @doc """
   get performance by id

   ## Examples 
   iex> Performances.get_performance(1)
   %Performance{}
   iex> Performances.get_performance(1000)
   ** (Ecto.NoResultsError)
  """
  def get_performance(performance_id) do
    Performance
    |> Repo.get(performance_id)
    |> Repo.preload(:artists)
  end

  @doc """
   create new performance

   ## Parameters
     - attrs: A map that represents the attributes

     ## Examples
     iex> Performances.create_performance(%{name: "Awesome Performance", detail: "some detail", amount_raised: 59})
     %Performance{name: "Awesome Performance", detail: "some detail", amount_raised: 59}

  """
  def create_performance(attrs \\ %{}) do
    %Performance{}
    |> Performance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
   gets a list of all Performances
  """
  def list_performances do
    Performance
    |> Repo.all()
    |> Repo.preload(:artists)
  end

  @doc """
  update_performances/2 updates values of a performance
  ## Examples

    iex> Performances.update_performance(%Performance{}, %{field: good_value})
    {:ok, %Performance{}}
    iex> Performances.update_performance(%Performance{}, %{field: bad_value})
    {:error: %Ecto.Changeset{}}
  """
  def update_performance(%Performance{} = performance, attrs) do
    performance
    |> Performance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  delete_performance/:id takes id and deletes a performance
  """
  def delete_performance(%Performance{} = performance) do
    Repo.delete(performance)
  end
end
