defmodule SingForNeeds.Repo.Migrations.AddBioToArtist do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table (:artists) do
      add :bio, :string
    end
  end
end
