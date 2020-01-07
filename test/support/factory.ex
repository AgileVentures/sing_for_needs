defmodule SingForNeeds.Factory do
  @moduledoc """
  Generate Factories for various schemas
  """
  # with Ecto
  use ExMachina.Ecto, repo: SingForNeeds.Repo

  alias SingForNeeds.Accounts.User
  alias SingForNeeds.Artists.Artist
  alias SingForNeeds.Causes.Cause
  alias SingForNeeds.Performances.Performance

  @doc """
  artist_factory/0 generates factories for for Artist object
  """
  @spec artist_factory :: SingForNeeds.Artists.Artist.t()
  def artist_factory do
    %Artist{
      name: sequence(:name, &"Awesome User #{&1}")
    }
  end

  def cause_factory do
    %Cause{
      name: sequence(:name, &"Awesome cause #{&1}"),
      description: sequence(:name, &"Awesome cause #{&1} Description"),
      start_date: ~D[2019-06-07]
    }
  end
  
  def performance_factory do
    %Performance{
      title: sequence(:name, &"Awesome performance #{&1}"),
      description: Faker.Lorem.paragraph(1),
      image_url: Faker.Avatar.image_url()
      }
  end
  def user_factory do
    %User{
      username: "awesome",
      email: "awesome@user.com",
      avatar_url: Faker.Avatar.image_url(),
      password: "supersecret"
    }
  end
end
