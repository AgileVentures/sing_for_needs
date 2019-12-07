defmodule SingForNeeds.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar_url, :string
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_hash, :avatar_url])
    |> validate_required([:username, :email, :password, :password_hash, :avatar_url])
  end
end
