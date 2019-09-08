defmodule SingForNeeds.PerformancesTest do
  @moduledoc """
  Tests for Performances schema
  """
  use SingForNeeds.DataCase

  alias SingForNeeds.Artists
  alias SingForNeeds.Performances
  alias SingForNeeds.Performances.Performance

  @valid_attrs %{name: "Awesome Performance A", detail: "Details about an awesome performance", amount_raised: 50 }

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

  # test "list_performances/0 returns a list of all performances" do
  #   {:ok, performance } = Performances.create_performance(@valid_attrs)
  #   [%Performance{} = performance_1] = Performances.list_performances()
  #   assert performance == performance_1
  #   assert performance.name == performance_1.name
  # end
end
