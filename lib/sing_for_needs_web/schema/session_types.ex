defmodule SingForNeedsWeb.Schema.SessionTypes do
  @moduledoc """
  All types for user
  """
  use Absinthe.Schema.Notation

  object :session do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end
end
