# Adds an Absinthe execution context to the Phoenix connection.
# If a valid auth token is in the request header, the corresponding
# user is added to the context which is then available to all
# resolvers. Otherwise, the context is empty.
#
# This plug runs prior to `Absinthe.Plug` in the `:api` router
# so that the context is set up and `Absinthe.Plug` can extract
# the context from the connection.

defmodule SingForNeedsWeb.Plugs.SetCurrentUser do
  @moduledoc """
  Plug to set the current user
  """
  @behaviour Plug
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{id: id}} <- SingForNeedsWeb.AuthToken.verify(token),
         %{} = user <- SingForNeeds.Accounts.get_user(id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
