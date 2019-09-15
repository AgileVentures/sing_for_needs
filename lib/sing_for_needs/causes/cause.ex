defmodule SingForNeeds.Causes.Cause do
  @moduledoc """
    Represents a cause for a specific perfomance
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SingForNeeds.Artists.Artist

  schema "causes" do
    field :description, :string
    field :end_date, :naive_datetime
    field :name, :string
    field :start_date, :naive_datetime
    field :amount_raised, :decimal
    field :target_amount, :decimal
    field :sponsor, :string
    # add supporting artists relationship (many to many)
    many_to_many :artists, Artist, join_through: "artist_causes"
    # add related causes relationship
    # add recent donors relationship
    # add organization relationship

    timestamps()
  end

  @doc false
  def changeset(cause, attrs) do
    cause
    |> cast(attrs, [:name, :description, :end_date, :start_date, 
                    :target_amount, :amount_raised, :sponsor])
    |> validate_required([:name, :description, :end_date])
    |> validate_period
  end

  @doc "validation for start_date < end_date"
  defp validate_period(changeset) do
    start_date = get_field(changeset, :start_date)
    end_date = get_field(changeset, :end_date)
    case changeset.valid? do
      true ->
        case start_date < end_date do
          true -> changeset
          _ -> add_error(changeset, :start_date, "Start Date should be less than End Date")  
        end
      _ ->
        changeset
    end
  end
end
