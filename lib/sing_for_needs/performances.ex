defmodule SingForNeeds.Performances do
 @moduledoc """
    Context for the performance schema
 """
 alias SingForNeeds.Artist
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
  create a performance with many artitsts
 """
#  def upsert_performance_artisits(performance, artist_ids) do
#     artists = 
#             Artist
#             |> where([artist], artist_id in ^artist_ids)
#             |> Repo.all()
#     with {:ok, _struct } <- 
#         performance
#         |> Performance.changeset_update_artists(artists)
#         |> Repo.update() do
#             {:ok, get_performance(performance.id)}
#     else error <-
#         error
#     end
#  end

end