defmodule SingForNeeds.PerformancesTest do
  @moduledoc """
  Tests for Performances schema
  """
  use SingForNeeds.DataCase

  alias SingForNeeds.Artists
  alias SingForNeeds.Performances
  alias SingForNeeds.Performances.Performance

  @valid_attrs %{name: "Awesome Performance A", detail: "Details about an awesome performance", amount_raised: 50 }

  @doc """
  performance_fixture/0 creates samlple performences in the database
  """
  def performance_fixture(attrs \\ %{}) do
    Performances.create_performance_with_artist(attrs)
  end

  test "create_performance/1 creates a new performance" do
    {:ok, %Performance{} = performance} = Performances.create_performance(@valid_attrs)
    assert performance.name == "Awesome Performance A"
    assert performance.detail == "Details about an awesome performance"
    assert performance.amount_raised == Decimal.new(50)
  end

  test "create_performance/2 can create a performance with many artists" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist 1", bio: "Awesome Artist 1"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist 2", bio: "Awesome Artist 2"})
    valid_attrs_with_artists = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    # %Performance{id: 1, name: "", description: "", artists: [artst_1, art]}

    {:ok, %Performance{artists: related_artists}} =  Performances.create_performance_with_artist(valid_attrs_with_artists)

    assert Enum.count(related_artists) == 2
    assert related_artists == [artist_1, artist_2]
  end

  @doc """
  list_performence/0 gets list of all the performences in the database
  """
  test "list_performances/0 returns a list of all performances" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist1", bio: "Awesome Artist One"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist2", bio: "Awesome Artist Two"})
    valid_attrs_with_artist = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    {:ok, performance } = performance_fixture(valid_attrs_with_artist)
    performances = Performances.list_performances()
    assert [performance] = performances
   end

   @doc """
   get_performance/:id gets a performance by id
   """
  test "get_performance/:id gets a performance by id" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist1", bio: "Awesome Artist One"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist2", bio: "Awesome Artist Two"})
    valid_attrs_with_artist = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    {:ok, performance } = performance_fixture(valid_attrs_with_artist)
    %Performance{id: id} = performance
    assert performance == Performances.get_performance(id)
  end
end
