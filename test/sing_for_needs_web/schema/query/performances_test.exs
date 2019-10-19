defmodule SingForNeeds.Schema.Query.PerformancesTest do
  @moduledoc """
  Test all the queries for Performance schema
  """
  use SingForNeedsWeb.ConnCase, async: true

  @query """
      query {
          performances {
              id
              detail
              amount_raised
          }
      }
  """

  test "returns a list of all performances in the database" do
    performances = performance_setup()
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "performances" => [
                 %{"detail" => "Details about an awesome performance 1"},
                 %{"detail" => "Details about an awesome performance 2"}
               ]
             }
           } = json_response(conn, 200)
  end
end
