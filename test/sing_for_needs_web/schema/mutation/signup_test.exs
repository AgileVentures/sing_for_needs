defmodule SingForNeedsWeb.Schema.Mutation.SignupTest do
  @moduledoc """
  Test for user signup
  """
  use SingForNeedsWeb.ConnCase, async: true

  @query """
  mutation signup($username: String!, $email: String!, $password: String!, $avatar_url: String) {
    signup(username: $username, email: $email, password: $password, avatar_url: $avatar_url) {
      user {
        username
      }
    }
  }

  """
  test "signing up" do
    input = %{
      username: "test",
      email: "test@example.com",
      password: "secret"
    }

    conn =
      post(build_conn(), "/api", %{
        query: @query,
        variables: input
      })

    assert %{
             "data" => %{
               "signup" => session
             }
           } = json_response(conn, 200)

    assert %{"user" => %{"username" => "test"}} == session
  end

  test "signup with invalid args returns error and details" do
    input = %{
      username: nil,
      email: "test@example.com",
      password: "sec"
    }

    conn =
      post(build_conn(), "/api", %{
        query: @query,
        variables: input
      })

    expected_result = %{
      "errors" => [
        %{
          "message" => "Argument \"username\" has invalid value $username."
        },
        %{
          "message" => "Variable \"username\": Expected non-null, found null."
        }
      ]
    }

    assert expected_result = json_response(conn, 200)
  end
end
