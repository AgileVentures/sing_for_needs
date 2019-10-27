defmodule SingForNeeds.ArtistsTest do
  @moduledoc false
  use SingForNeeds.DataCase
  import SingForNeeds.Factory
  alias SingForNeeds.Artists

  describe "artists" do
    alias SingForNeeds.Artists.Artist

    @valid_attrs %{name: "some name", bio: "An awesome artist's bio"}
    @update_attrs %{name: "some updated name", bio: "update an awesome artist's bio"}
    @invalid_attrs %{name: nil, bio: nil}

    def artist_fixture(attrs \\ %{}) do
      {:ok, artist} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Artists.create_artist()

      artist
    end

    test "list_artists/0 returns all artists" do
      artist = insert(:artist)
      assert Artists.list_artists() == [artist]
    end

    test "get_artist!/1 returns the artist with given id" do
      artist = artist_fixture()
      assert Artists.get_artist!(artist.id) == artist
    end

    test "create_artist/1 with valid data creates a artist" do
      assert {:ok, %Artist{} = artist} = Artists.create_artist(@valid_attrs)
      assert artist.name == "some name"
      assert artist.bio == "An awesome artist's bio"
    end

    test "create_artist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Artists.create_artist(@invalid_attrs)
    end

    test "create_artist/1 creates an artist with cause if cause is in attrs" do
      causes = insert_list(:cause, 4)
      require IEx; IEx.pry
      valid_attrs = Map.put(@valid_attrs, :causes, causes)
      valid_attrs
    end

    test "update_artist/2 with valid data updates the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{} = artist} = Artists.update_artist(artist, @update_attrs)
      assert artist.name == "some updated name"
      assert artist.bio == "update an awesome artist's bio"
    end

    test "update_artist/2 with invalid data returns error changeset" do
      artist = artist_fixture()
      assert {:error, %Ecto.Changeset{}} = Artists.update_artist(artist, @invalid_attrs)
      assert artist == Artists.get_artist!(artist.id)
    end

    test "delete_artist/1 deletes the artist" do
      artist = artist_fixture()
      assert {:ok, %Artist{}} = Artists.delete_artist(artist)
      assert_raise Ecto.NoResultsError, fn -> Artists.get_artist!(artist.id) end
    end

    test "change_artist/1 returns a artist changeset" do
      artist = artist_fixture()
      assert %Ecto.Changeset{} = Artists.change_artist(artist)
    end
  end
end
