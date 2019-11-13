defmodule SingForNeeds.Schema.Query.CauseTest do
  @moduledoc """
  Test all the queries for Cause schema
  """
  use Timex
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @query """
    query {
        causes {
            name
            artists {
              name
            }
        }
    }
  """

  @doc """
  Test get /api query returns json response of all causes
  """
  test "causes query returns all causes" do
    causes_fixture()
    conn = build_conn()
    conn = get conn, "/api", query: @query

    expected_result = %{
      "data" => %{
        "causes" => [
          %{
            "name" => "Awesome cause 0",
            "artists" => [%{"name" => "Artist 1"}, %{"name" => "Artist 2"}]
          },
          %{
            "name" => "Awesome cause 1",
            "artists" => [
              %{"name" => "Artist 1"},
              %{"name" => "Artist 2"},
              %{"name" => "Artist 3"}
            ]
          },
          %{"name" => "Awesome cause 2", "artists" => [%{"name" => "Artist 1"}]}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "causes query can filter causes with limit" do
    causes_limit_query = """
      query($limit: Int, $scope: String) {
          causes(limit: $limit, scope: $scope) {
              startDate
              artists {
                name
              }
          }
      }
    """

    insert_list(5, :cause)
    conn = build_conn()
    conn = post conn, "/api", query: causes_limit_query, variables: %{limit: 2}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"artists" => [], "startDate" => "2019-06-07"},
          %{"artists" => [], "startDate" => "2019-06-07"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "trending causes are ordered by most amount donated" do
    trending_causes_query = """
      query($limit: Int, $scope: String) {
          causes(limit: $limit, scope: $scope) {
              name
          }
      }
    """

    artists = insert_list(4, :artist)

    insert(:cause, %{
      name: "Cause with Medium Donation",
      amount_raised: 30_000,
      artists: Enum.take(artists, 2),
      description: Faker.Lorem.paragraph()
    })

    insert(:cause, %{name: "Cause with Least Donation", amount_raised: 10_000})

    insert(:cause, %{
      name: "Cause with Least Donation and two artists",
      amount_raised: 10_000,
      artists: Enum.take(artists, -2)
    })

    insert(:cause, %{name: "Cause with Highest Donation", amount_raised: 90_000, artists: artists})

    conn = build_conn()
    conn = post conn, "/api", query: trending_causes_query, variables: %{scope: "trending"}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"name" => "Cause with Highest Donation"},
          %{"name" => "Cause with Medium Donation"},
          %{"name" => "Cause with Least Donation and two artists"},
          %{"name" => "Cause with Least Donation"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "causes ending soon are ordered from the nearest end date" do
    causes_ending_soon_query = """
      query($scope: String) {
          causes(scope: $scope) {
              name
          }
      }
    """

    ten_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(10))
    twenty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(20))
    thirty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(30))
    insert(:cause, %{name: "Cause ends in 20 days", end_date: twenty_days_from_now})
    insert(:cause, %{name: "Cause ends in 30 days", end_date: thirty_days_from_now})
    insert(:cause, %{name: "Cause ends in 10 days", end_date: ten_days_from_now})
    conn = build_conn()
    conn = post conn, "/api", query: causes_ending_soon_query, variables: %{scope: "ending_soon"}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"name" => "Cause ends in 10 days"},
          %{"name" => "Cause ends in 20 days"},
          %{"name" => "Cause ends in 30 days"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "causes ending soon filters out causes with past end date" do
    causes_ending_soon_query = """
      query($scope: String) {
          causes(scope: $scope) {
              name
          }
      }
    """

    twenty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(20))
    thirty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(30))

    insert(:cause, %{name: "Cause ends in 30 days", end_date: thirty_days_from_now})
    insert(:cause, %{name: "Cause ends in 20 days", end_date: twenty_days_from_now})
    insert(:cause, %{name: "Cause ends in the past", end_date: ~D[2018-12-01]})
    conn = build_conn()
    conn = post conn, "/api", query: causes_ending_soon_query, variables: %{scope: "ending_soon"}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"name" => "Cause ends in 20 days"},
          %{"name" => "Cause ends in 30 days"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "causes ending soon and limit passed to causes query" do
    causes_ending_soon_with_limit_query = """
      query($scope: String, $limit: Int) {
          causes(scope: $scope, limit: $limit) {
              name
          }
      }
    """

    twenty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(20))
    thirty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(30))
    fifteen_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(15))
    five_days_ago = Timex.add(Timex.now(), Timex.Duration.from_days(-5))
    nine_days_ago = Timex.add(Timex.now(), Timex.Duration.from_days(-9))

    insert(:cause, %{name: "Cause ends in 30 days", end_date: thirty_days_from_now})
    insert(:cause, %{name: "Cause ends in 20 days", end_date: twenty_days_from_now})
    insert(:cause, %{name: "Cause ends in 15 days", end_date: fifteen_days_from_now})
    insert(:cause, %{name: "Cause ended 5 days ago", end_date: five_days_ago})
    insert(:cause, %{name: "Cause ended 9 days ago", end_date: nine_days_ago})

    conn = build_conn()

    conn =
      post conn, "/api",
        query: causes_ending_soon_with_limit_query,
        variables: %{scope: "ending_soon", limit: 2}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"name" => "Cause ends in 15 days"},
          %{"name" => "Cause ends in 20 days"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end

  test "scope: trending and limit:2 passed to causes query" do
    trending_causes_with_limit_query = """
      query($scope: String, $limit: Int) {
          causes(scope: $scope, limit: $limit) {
              name
          }
      }
    """

    artists = insert_list(4, :artist)

    insert(:cause, %{
      name: "Cause with Medium Donation",
      amount_raised: 30_000,
      artists: Enum.take(artists, 2),
      description: Faker.Lorem.paragraph()
    })

    insert(:cause, %{name: "Cause with Least Donation", amount_raised: 10_000})

    insert(:cause, %{
      name: "Cause with Least Donation and two artists",
      amount_raised: 10_000,
      artists: Enum.take(artists, -2)
    })

    insert(:cause, %{name: "Cause with Highest Donation", amount_raised: 90_000, artists: artists})

    conn = build_conn()

    conn =
      post conn, "/api",
        query: trending_causes_with_limit_query,
        variables: %{scope: "trending", limit: 3}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"name" => "Cause with Highest Donation"},
          %{"name" => "Cause with Medium Donation"},
          %{"name" => "Cause with Least Donation and two artists"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end
end
