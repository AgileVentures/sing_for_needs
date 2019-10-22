defmodule SingForNeeds.Schema.Query.CauseTest do
  @moduledoc """
  Test all the queries for Cause schema
  """
  use SingForNeedsWeb.ConnCase, async: true

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
                 %{"name" => "Awesome cause 1", "artists" =>  [%{"name" => "Artist 1"}, %{"name" => "Artist 2"}, %{"name" => "Artist 3"}]},
                 %{"name" => "Awesome cause 2",  "artists" => [%{"name" => "Artist 1"}]}
               ]
             }
           } = json_response(conn, 200)
  end
end
