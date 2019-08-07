defmodule SingForNeeds.Repo.Migrations.CreatePerformanceTable do
  @moduledoc """
  performances table
  """
  use Ecto.Migration

  def change do
    create table(:performances) do
      add :name, :string
      add :detail, :string
      add :amount_raised, :float
      references(:artists)
      timestamps()
    end
  end
end
