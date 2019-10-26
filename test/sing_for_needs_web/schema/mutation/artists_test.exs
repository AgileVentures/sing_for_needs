defmodule SingForNeedsWeb.Schema.Mutation.ArtistsTest do
  @moduledoc """
  Contains all tests for artists mutations
  """
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @create_artist_mutation """
    mutation($name: String!, $bio: String!, $causes: [ID]!) {
      createArtist(name: $name, bio: $bio, causes: $causes) {
        id
        name
        causes{
          name
          id
        }
        bio
      }
    }
  """
  test "create_artists/1 resolver creates an Artist" do
    conn = build_conn()
    cause = insert(:cause)

    input = %{
      name: "Lebron James",
      bio: "Greatest basketball player",
      causes: [cause.id]
    }

    conn = post conn, "/api", query: @create_artist_mutation, variables: input
    assert json_response(conn, 200) == input
  end
end
