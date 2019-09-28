defmodule SingForNeeds.Repo.Migrations.CreateCauses do
  @moduledoc """
    A Cause
  """
  use Ecto.Migration

  def change do
    create table(:causes) do
      add :name, :string, null: false
      add :description, :string, null: false
      add :end_date, :date
      add :start_date, :date, null: false
      add :amount_raised, :decimal
      add :target_amount, :decimal
      add :sponsor, :string
      timestamps()
    end

  end
end
