defmodule SingForNeedsWeb.ArtistController do
  use SingForNeedsWeb, :controller
  alias SingForNeeds.Model.Artist, as: ArtistModel
  alias SingForNeeds.Schema.Artist

  action_fallback SingForNeedsWeb.FallbackController

  def index(conn, _params) do
    artists = ArtistModel.list_artists()
    render(conn, "index.json", artists: artists)
  end

  def create(conn, %{"artist" => artist_params}) do
    with {:ok, %Artist{} = artist} <- ArtistModel.create_artist(artist_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.artist_path(conn, :show, artist))
      |> render("show.json", artist: artist)
    end
  end

  def show(conn, %{"id" => id}) do
    artist = ArtistModel.get_artist!(id)
    render(conn, "show.json", artist: artist)
  end

  def update(conn, %{"id" => id, "artist" => artist_params}) do
    artist = ArtistModel.get_artist!(id)

    with {:ok, %Artist{} = artist} <- ArtistModel.update_artist(artist, artist_params) do
      render(conn, "show.json", artist: artist)
    end
  end

  def delete(conn, %{"id" => id}) do
    artist = ArtistModel.get_artist!(id)

    with {:ok, %Artist{}} <- ArtistModel.delete_artist(artist) do
      send_resp(conn, :no_content, "")
    end
  end
end
