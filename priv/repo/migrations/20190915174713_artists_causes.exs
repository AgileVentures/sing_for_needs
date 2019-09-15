defmodule SingForNeeds.Repo.Migrations.ArtistsCauses do
  @moduledoc """
  Migration for join table between artists and causes
  """
  use Ecto.Migration

  def change do
    create table(:artists_causes) do
      add :artist_id, references(:artists)
      add :cause_id, references(:causes)
    end
  end
end
