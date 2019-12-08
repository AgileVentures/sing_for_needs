defmodule SingForNeedsWeb.Schema.Query.MeTest do
  @moduledoc """
  Contains tests for querying myself as a User
  """
  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory

  @query """
  {
    me {
      username
      avatar_url
    }
  }
  """
  test "me query returns my username and avatar_url" do
    user = insert(:user)

    conn = build_conn()
    conn = auth_user(conn, user)

    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "me" => %{
                 "username" => user_name,
                 "avatar_url" => avatar_url
               }
             }
           } = json_response(conn, 200)

    assert user.username == user_name
  end

  test "me query fails if not signed in" do
    conn = build_conn()

    conn = get conn, "/api", query: @query

    assert %{
             "data" => %{
               "me" => nil
             }
           } == json_response(conn, 200)
  end
end
