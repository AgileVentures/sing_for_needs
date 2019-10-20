defmodule SingForNeeds.Repo.Migrations.AddArtistPerformance do
  use Ecto.Migration

  def change do
    create table(:artists_performances, primary_key: false) do
      add(:artist_id, references(:artists, on_delete: :delete_all), primary_key: true)
      add(:performance_id, references(:performances, on_delete: :delete_all), primary_key: true)
    end

    create(index(:artists_performances, [:artist_id]))
    create(index(:artists_performances, [:performance_id]))

    create(
      unique_index(:artists_performances, [:artist_id, :performance_id],
        name: :artist_id_performance_id_unique_index
      )
    )
  end
end
