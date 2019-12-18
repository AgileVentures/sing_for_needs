defmodule SingForNeedsWeb.Resolvers.Accounts do
  @moduledoc """
  Resolvers for User
  """
  alias SingForNeeds.Accounts
  alias SingForNeedsWeb.Schema.ChangesetErrors

  @doc """
  signin 3 calls the authenticate method that returns a logged in user
  """
  def signin(_parent, %{username: username, password: password}, _resolution) do
    case Accounts.authenticate(username, password) do
      {:error, error} ->
        require IEx
        IEx.pry()
        {:error, %{error: "Some error message"}}

      {:ok, user} ->
        require IEx
        IEx.pry()
        {:ok, user}
    end
  end

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
