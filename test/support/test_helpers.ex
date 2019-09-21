defmodule SingForNeeds.TestHelpers do
  @moduledoc false
  alias SingForNeeds.Artists.Artist
  alias SingForNeeds.Causes.Cause
  alias SingForNeeds.Repo

  def artists_fixture do
    artist1 = %Artist{
      name: "Artist 1"
    }

    artist1 = Repo.insert!(artist1)

    artist2 = %Artist{
      name: "Artist 2"
    }

    artist2 = Repo.insert!(artist2)

    artist3 = %Artist{
      name: "Artist 3"
    }

    artist3 = Repo.insert!(artist3)
    [artist1, artist2, artist3]
  end

  def causes_fixture do
    artists = artists_fixture()

    cause_1 =
      %Cause{
        description: "Awesome cause 1 description",
        end_date: ~N[2010-10-17 14:00:00],
        start_date: ~N[2010-09-17 14:00:00],
        target_amount: 30_000,
        amount_raised: 3000,
        sponsor: "Awesome sponsor 1",
        name: "Awesome cause 1",
        artists: artists
      }
      |> Repo.insert!()

    cause_2 =
      %Cause{
        description: "Awesome cause 2 description",
        end_date: ~N[2010-10-17 14:00:00],
        start_date: ~N[2010-09-17 14:00:00],
        target_amount: 30_000,
        amount_raised: 3000,
        sponsor: "Awesome sponsor 2",
        name: "Awesome cause 2",
        artists: [List.first(artists)]
      }
      |> Repo.insert!()

    [cause_1, cause_2]
  end
end
