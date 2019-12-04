defmodule SingForNeeds.Schema.Query.PerformancesTest do
  @moduledoc """
  Test all the queries for Performance schema
  """
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @query """
      query {
          performances {
              description
          }
      }
  """

  test "returns a list of all performances in the database" do
    insert(:performance, %{
      title: "Awesome performance 1",
      description: "Details about an awesome performance 1"
    })

    insert(:performance, %{
      title: "Awesome performance 1",
      description: "Details about an awesome performance 2"
    })

    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "performances" => [
                 %{"description" => "Details about an awesome performance 1"},
                 %{"description" => "Details about an awesome performance 2"}
               ]
             }
           } = json_response(conn, 200)
  end
end
