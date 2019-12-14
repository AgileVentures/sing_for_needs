defmodule SingForNeeds.TestHelpers do
  @moduledoc false
  use Timex
  import SingForNeeds.Factory
  alias SingForNeeds.Artists.Artist
  alias SingForNeeds.Causes.Cause
  alias SingForNeeds.Performances.Performance
  alias SingForNeeds.Repo

  @spec artists_fixture :: [...]
  def artists_fixture do
    cause_attrs = %Cause{
      description: "Awesome cause 0 description",
      end_date: ~D[2010-10-17],
      start_date: ~D[2010-09-17],
      target_amount: 30_000,
      amount_raised: 3000,
      sponsor: "Awesome sponsor 0",
      name: "Awesome cause 0"
    }

    cause = Repo.insert!(cause_attrs)

    artist1 = %Artist{
      name: "Artist 1",
      causes: [cause]
    }

    artist1 = Repo.insert!(artist1)

    artist2 = %Artist{
      name: "Artist 2",
      causes: [cause]
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
        end_date: ~D[2010-10-17],
        start_date: ~D[2010-09-17],
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
        end_date: ~D[2010-10-17],
        start_date: ~D[2010-09-17],
        target_amount: 30_000,
        amount_raised: 3000,
        sponsor: "Awesome sponsor 2",
        name: "Awesome cause 2",
        artists: [List.first(artists)]
      }
      |> Repo.insert!()

    [cause_1, cause_2]
  end

  def setup_causes do
    artists = insert_list(4, :artist)
    twenty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(20))
    thirty_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(30))
    fifteen_days_from_now = Timex.add(Timex.now(), Timex.Duration.from_days(15))
    five_days_ago = Timex.add(Timex.now(), Timex.Duration.from_days(-5))
    nine_days_ago = Timex.add(Timex.now(), Timex.Duration.from_days(-9))

    insert(:cause, %{
      name: "Awesome cause 1",
      end_date: thirty_days_from_now,
      amount_raised: 30_000,
      artists: Enum.take(artists, 2),
      description: Faker.Lorem.paragraph(1)
    })

    insert(:cause, %{
      name: "Awesome Cause 2",
      end_date: twenty_days_from_now,
      amount_raised: 10_000
    })

    insert(:cause, %{name: "Awesome Cause 3", end_date: fifteen_days_from_now})

    insert(:cause, %{
      name: "Awesome cause 4",
      end_date: five_days_ago,
      amount_raised: 10_000,
      artists: Enum.take(artists, -2)
    })

    insert(:cause, %{
      name: "Awesome cause 5",
      end_date: nine_days_ago,
      amount_raised: 90_000,
      artists: artists
    })
  end

  def performance_setup do
    performance_1_attrs = %Performance{
      detail: "Details about an awesome performance 1",
      amount_raised: 50
    }

    performance_1 = Repo.insert!(performance_1_attrs)

    performance_2_attrs = %Performance{
      detail: "Details about an awesome performance 2",
      amount_raised: 60
    }

    performance_2 = Repo.insert!(performance_2_attrs)
    [performance_1, performance_2]
  end

  @doc """
  creates hashed password and adds it to user struct
  ## parameters 
  - user
  - password

  Returns user struct
  ## Examples
  iex> set_password(user, password)
  %User{password_hash: r^8s8d7f6g6-@fsdfseshwewqwd}
  """
  def set_password(user, password) do
    password_hash = Pbkdf2.hash_pwd_salt(password)
    %{user | password_hash: password_hash}
  end
end
