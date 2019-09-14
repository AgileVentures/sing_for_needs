defmodule SingForNeeds.PerformancesTest do
  @moduledoc """
  Tests for Performances schema
  """
  use SingForNeeds.DataCase

  alias SingForNeeds.Artists
  alias SingForNeeds.Performances
  alias SingForNeeds.Performances.Performance

  @valid_attrs %{
    name: "Awesome Performance A",
    detail: "Details about an awesome performance",
    amount_raised: 50
  }
  @invalid_atts %{name: nil, detail: nil, amount_raised: nil}
  @update_attrs %{name: "Updated Awesome Performance", amount_raised: Decimal.new(100)}

  @doc """
  performance_fixture/0 creates samlple performences in the database
  """
  def performance_fixture(attrs \\ %{}) do
    {:ok, performance} = Performances.create_performance_with_artist(attrs)
    performance
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

    {:ok, %Performance{artists: related_artists}} =
      Performances.create_performance_with_artist(valid_attrs_with_artists)

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
    performance = performance_fixture(valid_attrs_with_artist)
    performances = Performances.list_performances()
    assert [performance] = performances
  end

  @doc """
  get_performance/:id gets a performance by id
  """
  test "get_performance/:id gets a performance by id" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist1", bio: "Awesome Artist One"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist2", bio: "Awesome Artist Two"})
    valid_attrs_with_artists = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    performance = performance_fixture(valid_attrs_with_artists)
    %Performance{id: id} = performance
    assert performance == Performances.get_performance(id)
  end

  @doc """
  update_performance/2 returns an updated Performance
  """
  test "update_performance/2 updates name and amount_raised" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist1", bio: "Awesome Artist One"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist2", bio: "Awesome Artist Two"})
    valid_attrs_with_artists = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    performance = performance_fixture(valid_attrs_with_artists)
    update_performance_with_artist = Map.put(@update_attrs, :artists, [artist_1, artist_2])

    {:ok, updated_performance} =
      Performances.update_performance(performance, update_performance_with_artist)

    assert performance.id == updated_performance.id
    assert updated_performance.name == "Updated Awesome Performance"
    assert updated_performance.amount_raised == Decimal.new(100)
  end

  @doc """
  delete_performance/1  deletes a single performance
  """
  test "delete_performance/1 deletes a performance" do
    {:ok, artist_1} = Artists.create_artist(%{name: "Awesome Artist1", bio: "Awesome Artist One"})
    {:ok, artist_2} = Artists.create_artist(%{name: "Awesome Artist2", bio: "Awesome Artist Two"})
    valid_attrs_with_artists = Map.put(@valid_attrs, :artists, [artist_1, artist_2])
    performance = performance_fixture(valid_attrs_with_artists)
    {:ok, deleted_performance} = Performances.delete_performance(performance)
    assert length(Performances.list_performances()) == 0
    assert length(Artists.list_artists()) == 2
  end
end
