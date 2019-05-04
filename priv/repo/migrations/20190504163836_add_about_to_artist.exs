defmodule SingForNeeds.Repo.Migrations.AddAboutToArtist do
  use Ecto.Migration

  def change do
    alter table (:artists) do
      add :about, :string
    end
  end
end
