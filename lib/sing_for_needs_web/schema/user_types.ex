defmodule SingForNeedsWeb.Schema.UserTypes do
  @moduledoc """
  All types for user
  """
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :avatar_url, :string
    field :email, :string
    field :password, :string
    field :password_hash, :string
    field :username, :string
  end
end
