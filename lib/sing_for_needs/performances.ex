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
    Create new performance with artists
    ## Parameters
    - attrs: a map that represents the attributes

    ## Examples
    iex> Performances.create_performance(%{name: "Awesome Performance", detail: "some detail", amount_raised: 59, artists: [id: 1, name: "awesome artist", bio: "awesone"]})
    %Performance{id: 1, name: "Awesome Performance", detail: "some detail", amount_raised: 59, artists: [id: 1, name: "awesome artist", bio: "awesone"]}
  """
  def create_performance_with_artist(attrs \\ %{}) do
    %Performance{}
    |> Performance.changeset_update_artists(attrs)
    |> Repo.insert()
  end

  @doc """
    gets a list of all Performances
   """
  def list_performances do
    Performance
      |>Repo.all()
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
  def update_performance(performance \\ %Performance{}, attrs \\ %{}) do
    performance
      |> Performance.changeset_update_artists(attrs)
      |> Repo.update()
  end
end
