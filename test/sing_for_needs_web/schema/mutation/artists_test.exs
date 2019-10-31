defmodule SingForNeedsWeb.Schema.Mutation.ArtistsTest do
  @moduledoc """
  Contains all tests for artists mutations
  """
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @create_artist_mutation """
    mutation($name: String!, $bio: String!, $causes: [ID]) {
      createArtist(name: $name, bio: $bio, causes: $causes) {
        name
        causes{
          startDate
        }
        bio
      }
    }
  """
  @update_artist_mutation """
    mutation($artistId: ID!, $name: String, $bio: String) {
      updateArtist(artistId: $artistId, name: $name, bio: $bio) {
        name
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

    expected_result = %{
      "data" => %{
        "createArtist" => %{
          "bio" => "Greatest basketball player",
          "causes" => [%{"startDate" => "2019-06-07"}],
          "name" => "Lebron James"
        }
      }
    }

    conn = post conn, "/api", query: @create_artist_mutation, variables: input
    assert expected_result == json_response(conn, 200)
  end

  test "update_artist/1 updates an artist" do
    conn = build_conn()
    artist = insert(:artist)
    input = %{
      artistId: artist.id,
      name: "Stephen Curry",
      bio: "Cheff curry with the pot"
    }

    conn = post conn, "/api", query: @update_artist_mutation, variables: input
    assert input == json_response(conn, 200)
  end
end
