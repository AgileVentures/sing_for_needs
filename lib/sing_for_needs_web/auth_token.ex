defmodule SingForNeedsWeb.AuthToken do
  @moduledoc """
  Implements assignment of a token to a user requesting access and verification 
  wheter the token provided by a user is valid
  """
  @user_salt "user salt"
  @doc """
  Encodes a given user id, signs it returning a token
  Clients can use as identification when using the API 
  """
  def sign(user) do
    Phoenix.Token.sign(SingForNeedsWeb.Endpoint, @user_salt, %{id: user.id})
  end

  @doc """
  Decodes original data from the given token, 
  and verifies its integrity
  """
  def verify(token) do
    Phoenix.Token.verify(SingForNeedsWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
