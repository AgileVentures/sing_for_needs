defmodule SingForNeeds.Factory do
  @moduledoc """
  Generate Factories for various schemas
  """
  # with Ecto
  use ExMachina.Ecto, repo: SingForNeeds.Repo

  alias SingForNeeds.Artists.Artist
  alias SingForNeeds.Causes.Cause

  @doc """
  artist_factory/0 generates factories for for Artist object

  ## Example
  iex> artist_factory()
  """
  @spec artist_factory :: SingForNeeds.Artists.Artist.t()
  def artist_factory do
    %Artist{
      name: sequence(:name, &"Awesome User #{&1}")
    }
  end

  def cause_factory do
    %Cause{
      name: sequence(:name, &"Awesome Cause #{&1}"),
      description: sequence(:name, &"Awesome Cause #{&1} Description"),
      start_date: ~D[2019-10-10]
    }
  end
end
