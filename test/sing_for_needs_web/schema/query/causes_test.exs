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

    expected_response = %{
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

    json_response = json_response(conn, 200)
    assert expected_response == json_response
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

    expected_response = %{
      "data" => %{
        "causes" => [
          %{"artists" => [], "startDate" => "2019-06-07"},
          %{"artists" => [], "startDate" => "2019-06-07"}
        ]
      }
    }

    json_response = json_response(conn, 200)
    assert expected_response == json_response
  end

  test "trending causes are ordered by most amount donated and number of artists" do
    trending_causes_query = """
      query($limit: Int, $scope: String) {
          causes(limit: $limit, scope: $scope) {
              name
          }
      }
    """

    setup_causes()
    conn = build_conn()
    conn = post conn, "/api", query: trending_causes_query, variables: %{scope: "trending"}

    expected_response = %{
      "data" => %{
        "causes" => [
          %{"name" => "Awesome Cause 3"},
          %{"name" => "Awesome cause 5"},
          %{"name" => "Awesome cause 1"},
          %{"name" => "Awesome cause 4"},
          %{"name" => "Awesome Cause 2"}
        ]
      }
    }

    response = json_response(conn, 200)
    assert expected_response == response
  end

  test "causes ending soon are ordered from the nearest end date" do
    causes_ending_soon_query = """
      query($scope: String) {
          causes(scope: $scope) {
              name
          }
      }
    """

    setup_causes()
    conn = build_conn()
    conn = post conn, "/api", query: causes_ending_soon_query, variables: %{scope: "ending_soon"}

    expected_response = %{
      "data" => %{
        "causes" => [
          %{"name" => "Awesome Cause 3"},
          %{"name" => "Awesome Cause 2"},
          %{"name" => "Awesome cause 1"}
        ]
      }
    }

    response = json_response(conn, 200)
    assert expected_response == response
  end

  test "causes ending soon filters out causes with past end date" do
    causes_ending_soon_query = """
      query($scope: String) {
          causes(scope: $scope) {
              name
          }
      }
    """

    setup_causes()
    conn = build_conn()
    conn = post conn, "/api", query: causes_ending_soon_query, variables: %{scope: "ending_soon"}

    expected_response = %{
      "data" => %{
        "causes" => [
          %{"name" => "Awesome Cause 3"},
          %{"name" => "Awesome Cause 2"},
          %{"name" => "Awesome cause 1"}
        ]
      }
    }

    response = json_response(conn, 200)
    assert expected_response == response
  end

  test "causes ending soon and limit passed to causes query" do
    causes_ending_soon_with_limit_query = """
      query($scope: String, $limit: Int) {
          causes(scope: $scope, limit: $limit) {
              name
          }
      }
    """

    setup_causes()
    conn = build_conn()

    conn =
      post conn, "/api",
        query: causes_ending_soon_with_limit_query,
        variables: %{scope: "ending_soon", limit: 2}

    expected_result = %{
      "data" => %{
        "causes" => [%{"name" => "Awesome Cause 3"}, %{"name" => "Awesome Cause 2"}]
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

    setup_causes()
    conn = build_conn()

    conn =
      post conn, "/api",
        query: trending_causes_with_limit_query,
        variables: %{scope: "trending", limit: 3}

    expected_response = %{
      "data" => %{
        "causes" => [
          %{"name" => "Awesome Cause 3"},
          %{"name" => "Awesome cause 5"},
          %{"name" => "Awesome cause 1"}
        ]
      }
    }

    response = json_response(conn, 200)

    assert expected_response == response
  end
end
