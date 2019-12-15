defmodule SingForNeedsWeb.Schema.Mutation.SigninTest do
  @moduledoc """
  Test for user sign in
  """

  use SingForNeedsWeb.ConnCase, async: true
  import SingForNeeds.Factory
  alias SingForNeeds.Accounts.User

  @query """
    mutation($username: String!, $password: String!) 
    {
        signin(username: $username, password: $password) {
          user {
            username
            email
            avatar_url
          }
          token  
        }
    }
  """

  test "sign in for valid user" do
    user = build(:user, %{username: "awesome"})
    user = set_password(user, "supersecret")
    user = insert(user)

    conn =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{username: "awesome", password: "supersecret"}
      })

    assert %{
              "data" => %{
              "signin" => session
             }
           } = json_response(conn, 200)
  end
end
