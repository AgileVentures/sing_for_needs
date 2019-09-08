defmodule SingForNeeds.Performances do
 @moduledoc """
    Context for the performance schema
 """
 alias SingForNeeds.Performances.Performance
 alias SingForNeeds.Repo

 @doc """
  get performance by id
 """
 def get_performance(performance_id) do
    Repo.get(Performace, performance_id)
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
    List of all Performances
   """
  def list_performances do
    Repo.all(Performance)
  end
end
