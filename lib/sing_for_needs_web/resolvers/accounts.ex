defmodule SingForNeedsWeb.Resolvers.Accounts do
  @moduledoc """
  Resolvers for User
  """
  alias SingForNeeds.Accounts
  alias SingForNeedsWeb.Schema.ChangesetErrors

  def signup(_parent, args, _resolution) do
    case Accounts.create_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = SingForNeedsWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def me(_parent, _args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_parent, _args, _resolution) do
    {:ok, nil}
  end
end
