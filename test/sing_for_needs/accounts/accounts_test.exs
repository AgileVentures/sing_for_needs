defmodule SingForNeeds.AccountsTest do
  @moduledoc """
  Tests for the Accounts contest
  """
  use SingForNeeds.DataCase
  import SingForNeeds.Factory
  alias SingForNeeds.Accounts
  alias SingForNeeds.Accounts.User

  describe "users" do
    @valid_attrs %{
      avatar_url: "some avatar_url",
      email: "some email",
      password: "some password",
      username: "some username"
    }
    @update_attrs %{
      avatar_url: "some updated avatar_url",
      email: "some updated email",
      password: "some updated password",
      username: "some updated username"
    }
    @invalid_attrs %{
      avatar_url: nil,
      email: nil,
      password: nil,
      password_hash: nil,
      username: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()

      assert [
               Enum.map(
                 Accounts.list_users(),
                 &Map.take(&1, [:id, :username, :email, :avatar_url])
               )
             ] == [Enum.map([user], &Map.take(&1, [:id, :username, :email, :avatar_url]))]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      same_user = Accounts.get_user!(user.id)
      assert user.avatar_url == same_user.avatar_url
      assert user.email == same_user.email
      assert user.password_hash
      assert user.username == same_user.username
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.avatar_url == "some avatar_url"
      assert user.email == "some email"
      assert user.password == "some password"
      assert user.password_hash
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.avatar_url == "some updated avatar_url"
      assert user.email == "some updated email"
      assert user.password == "some updated password"
      assert user.password_hash
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      same_user = Accounts.get_user!(user.id)
      assert user.avatar_url == same_user.avatar_url
      assert user.email == user.email
      assert user.username == same_user.username
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "authenticate/2" do
    @username "awesome"
    @password "secret"
    @avatar_url "http://avatar.url"

    defp set_password(user, password) do
      password_hash = Pbkdf2.hash_pwd_salt(password)
      %{user | password_hash: password_hash}
    end

    def setup do
      user = build(:user, %{username: @username, avatar_url: @avatar_url})
      user = set_password(user, @password)
      insert(user)
    end

    test "with valid username and password returns the user" do
      setup()

      assert %User{username: username, email: email, avatar_url: avatar_url} =
               Accounts.authenticate(@username, @password)
    end
  end
end
