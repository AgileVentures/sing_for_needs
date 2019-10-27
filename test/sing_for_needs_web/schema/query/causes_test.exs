defmodule SingForNeeds.Schema.Query.CauseTest do
  @moduledoc """
  Test all the queries for Cause schema
  """
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @query_with_args """
    query($limit: ID) {
        causes(limit: $limit) {
            id
            name
            artists {
              name
            }
        }
    }
  """
  @query """
    query {
        causes {
            id
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

    assert %{
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
           } = json_response(conn, 200)
  end

  test "causes query can filter causes with limit" do
    causes = insert_list(5, :cause)
    conn = build_conn()
    conn = post conn, "/api", query: @query_with_args, variables: %{limit: 2}

    expected_result = %{
      "data" => %{
        "causes" => [
          %{"artists" => [], "id" => "1", "name" => "Awesome Cause 0"},
          %{"artists" => [], "id" => "2", "name" => "Awesome Cause 2"}
        ]
      }
    }

    assert expected_result == json_response(conn, 200)
  end
end
