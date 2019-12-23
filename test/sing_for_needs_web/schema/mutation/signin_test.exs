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

  test "sign in for valid user retuens user and token" do
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

    assert %{"token" => token, "user" => user_data} = session
    %User{username: username, avatar_url: avatar_url, email: email, id: user_id} = user
    assert %{"username" => username, "email" => email, "avatar_url" => avatar_url} == user_data
    assert {:ok, %{id: user_id}} == SingForNeedsWeb.AuthToken.verify(token)
  end

  test "sign in for invalid user returns error" do
    user = build(:user, %{username: "awesome"})
    user = set_password(user, "supersecret")
    user = insert(user)

    conn =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{username: "invalid", password: "supersecret"}
      })

    expected_response = %{
      "data" => %{"signin" => nil},
      "errors" => [%{"message" => "Whoops, Invalid credentials"}]
    }

    expected_response == json_response(conn, 200)
  end
end
