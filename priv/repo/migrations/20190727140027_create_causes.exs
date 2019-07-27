defmodule SingForNeeds.Repo.Migrations.CreateCauses do
  @moduledoc """
    A Cause
  """
  use Ecto.Migration

  def change do
    create table(:causes) do
      add :name, :string
      add :description, :string
      add :end_date, :naive_datetime
      add :start_date, :naive_datetime
      add :amount_raised, :integer
      add :target_amount, :integer
      add :sponsor, :string
      timestamps()
    end

  end
end
