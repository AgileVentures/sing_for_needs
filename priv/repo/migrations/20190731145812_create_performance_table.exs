defmodule SingForNeeds.Repo.Migrations.CreatePerformanceTable do
  @moduledoc """
  performances table
  """
  use Ecto.Migration

  def change do
    create table(:performances) do
      add :name, :string
      add :detail, :string
      add :ammount_raised, :float
      references(:artists)
    end
  end
end
