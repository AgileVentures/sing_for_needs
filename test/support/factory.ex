defmodule SingForNeeds.Factory do
  @moduledoc """
  Generate Factories for various schemas
  """
  # with Ecto
  use ExMachina.Ecto, repo: SingForNeeds.Repo

  alias SingForNeeds.Artists.Artist

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
end
