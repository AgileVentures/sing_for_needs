defmodule SingForNeeds.Repo.Migrations.CreatePerformanceTable do
  @moduledoc """
  performances table
  """
  use Ecto.Migration

  def change do
    create table(:performances) do
      add :title, :string
      add :description, :string
      add :image_url, :string
      add :performance_date, :date
      add :location, :string
      add :cause_id, references(:causes)
      references(:artists)
      timestamps()
    end
  end
end
