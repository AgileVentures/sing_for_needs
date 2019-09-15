defmodule SingForNeeds.CausesTest do
  @moduledoc """
    Unit tests for Causes context
  """
  use SingForNeeds.DataCase

  alias SingForNeeds.Artists
  alias SingForNeeds.Causes

  describe "causes" do
    alias SingForNeeds.Causes.Cause

    @valid_attrs %{
      description: "some description",
      end_date: ~N[2010-10-17 14:00:00],
      start_date: ~N[2010-09-17 14:00:00],
      target_amount: 30_000,
      raised_amount: 3000,
      sponsor: "unicef",
      name: "Go Blue on World Children's Day"
    }
    @update_attrs %{
      description: "some updated description",
      end_date: ~N[2011-05-18 15:01:01],
      name: "some updated name"
    }
    @invalid_attrs %{description: nil, end_date: nil, name: nil}

    def cause_fixture(attrs \\ %{}) do
      {:ok, cause} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Causes.create_cause()

      cause
    end

    test "list_causes/0 returns all causes" do
      cause = cause_fixture()
      assert Causes.list_causes() == [cause]
    end

    test "get_cause!/1 returns the cause with given id" do
      cause = cause_fixture()
      assert Causes.get_cause!(cause.id) == cause
    end

    test "create_cause/1 with valid data creates a cause" do
      assert {:ok, %Cause{} = cause} = Causes.create_cause(@valid_attrs)
      assert cause.description == "some description"
      assert cause.end_date == ~N[2010-10-17 14:00:00]
      assert cause.name == "Go Blue on World Children's Day"
    end

    test "create_cause/1 creates a cause with many artists" do
      {:ok, artist_1} =
        Artists.create_artist(%{name: "Awesome Artist 1", bio: "Awesome Artist 1 bio"})

      {:ok, artist_2} =
        Artists.create_artist(%{name: "Awesome Artist 2", bio: "Awesome Artist 2 bio"})

      valid_attrs_with_artists = Map.put(@valid_attrs, :artists, Artists.list_artists())
      {:ok, cause} = Causes.create_cause_with_artists(valid_attrs_with_artists)
      assert length(cause.artists) == 2
      assert cause.name == "Go Blue on World Children's Day"
      assert cause.target_amount == Decimal.new(30_000)
    end

    test "create_cause/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Causes.create_cause(@invalid_attrs)
    end

    test "update_cause/2 with valid data updates the cause" do
      cause = cause_fixture()
      assert {:ok, %Cause{} = cause} = Causes.update_cause(cause, @update_attrs)
      assert cause.description == "some updated description"
      assert cause.end_date == ~N[2011-05-18 15:01:01]
      assert cause.name == "some updated name"
    end

    test "update_cause/2 with invalid data returns error changeset" do
      cause = cause_fixture()
      assert {:error, %Ecto.Changeset{}} = Causes.update_cause(cause, @invalid_attrs)
      assert cause == Causes.get_cause!(cause.id)
    end

    test "delete_cause/1 deletes the cause" do
      cause = cause_fixture()
      assert {:ok, %Cause{}} = Causes.delete_cause(cause)
      assert_raise Ecto.NoResultsError, fn -> Causes.get_cause!(cause.id) end
    end

    test "change_cause/1 returns a cause changeset" do
      cause = cause_fixture()
      assert %Ecto.Changeset{} = Causes.change_cause(cause)
    end

    @tag :skip
    test "start date should be less than end date" do
      # "TODO: Need to figure out the date comparison"
      cause = cause_fixture()
      invalid_date_attrs = %{end_date: ~N[2010-08-18 15:01:01]}
      assert {:error, %Ecto.Changeset{}} = Causes.update_cause(cause, invalid_date_attrs)
      assert cause == Causes.get_cause!(cause.id)
    end
  end
end
