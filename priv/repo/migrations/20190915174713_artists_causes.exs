defmodule SingForNeeds.Repo.Migrations.ArtistsCauses do
  @moduledoc """
  Migration for join table between artists and causes
  """
  use Ecto.Migration

  def change do
    create table(:artists_causes) do
      add :artist_id, references(:artists, on_delete: :delete_all)
      add :cause_id, references(:causes, on_delete: :delete_all)
    end

    create unique_index(:artists_causes, [:artist_id, :cause_id])
  end
end
