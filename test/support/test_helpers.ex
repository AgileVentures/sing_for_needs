defmodule SingForNeeds.TestHelpers do
    @moduledoc false
    alias SingForNeeds.Artists.Artist
    alias SingForNeeds.Repo

  def artists_fixture do
    artist1 =
      %Artist{
        name: "Artist 1",
      }
    artist1 = Repo.insert!(artist1)

    artist2 =
      %Artist{
        name: "Artist 2",
      }
      artist2 = Repo.insert!(artist2)

    artist3 =
      %Artist{
        name: "Artist 3",
      }
    artist3 = Repo.insert!(artist3)
    [artist1, artist2, artist3]
  end
end
