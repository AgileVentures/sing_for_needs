defmodule SingForNeedsWeb.Schema.UserTypes do
  @moduledoc """
  All types for user
  """
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :avatar_url, :string
    field :email, :string
    field :username, :string
  end
end
