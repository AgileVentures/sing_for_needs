defmodule SingForNeeds.Schema.Query.ArtistsTest do
  @moduledoc false
  use SingForNeedsWeb.ConnCase, async: true

  @query """
  {
    artists {
      name
    }
  }
  """
  test "artists query returns all artists" do
    artists_fixture()
    import IEx; IEx.pry
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert %{"data" => %{
      "artists" => [
        %{"name" => "Artist 1"},
        %{"name" => "Artist 2"},
        %{"name" => "Artist 3"}
      ]
      }
    } = json_response(conn, 200)
  end
end
