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
      description: "Go Blue description",
      end_date: "2010-10-17",
      start_date: "2010-09-17",
      target_amount: 30_000,
      raised_amount: 3000,
      sponsor: "unicef",
      name: "Go Blue on World Children's Day"
    }
    @update_attrs %{
      description: "some updated description",
      end_date: "2011-05-18",
      name: "some updated name"
    }
    @invalid_attrs %{description: nil, end_date: nil, name: nil}

    def cause_setup(attrs \\ %{}) do
      {:ok, cause} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Causes.create_cause()

      cause
    end

    def create_artists do
      Artists.create_artist(%{name: "Awesome Artist 1", bio: "Awesome Artist 1 bio"})
      Artists.create_artist(%{name: "Awesome Artist 2", bio: "Awesome Artist 2 bio"})
      Artists.list_artists()
    end

    test "list_causes/0 returns all causes" do
      cause = cause_setup()
      assert Causes.list_causes() == [cause]
    end

    test "get_cause!/1 returns the cause with given id" do
      cause = cause_setup()
      assert Causes.get_cause!(cause.id) == cause
    end

    test "create_cause/1 with valid data creates a cause" do
      assert {:ok, %Cause{} = cause} = Causes.create_cause(@valid_attrs)
      assert cause.description == @valid_attrs.description
      assert cause.end_date == ~D[2010-10-17]
      assert cause.name == @valid_attrs.name
    end

    test "create_cause/1 creates a cause with many artists" do
      artists = create_artists()
      valid_attrs_with_artists = Map.put(@valid_attrs, :artists, artists)
      {:ok, cause} = Causes.create_cause_with_artists(valid_attrs_with_artists)
      assert length(cause.artists) == 2
      assert cause.name == @valid_attrs.name
      assert cause.description == @valid_attrs.description
      assert cause.target_amount == Decimal.new(@valid_attrs.target_amount)
      assert cause.artists == artists
    end

    test "create_cause/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Causes.create_cause(@invalid_attrs)
    end

    test "update_cause/2 with valid data updates the cause" do
      cause = cause_setup()
      assert {:ok, %Cause{} = cause} = Causes.update_cause(cause, @update_attrs)
      assert cause.description == @update_attrs.description
      assert cause.end_date == ~D[2011-05-18]
      assert cause.name == @update_attrs.name
    end

    test "update_cause/2 with invalid data returns error changeset" do
      cause = cause_setup()
      assert {:error, %Ecto.Changeset{}} = Causes.update_cause(cause, @invalid_attrs)
      assert cause == Causes.get_cause!(cause.id)
    end

    test "delete_cause/1 deletes the cause" do
      cause = cause_setup()
      assert {:ok, %Cause{}} = Causes.delete_cause(cause)
      assert_raise Ecto.NoResultsError, fn -> Causes.get_cause!(cause.id) end
    end

    test "change_cause/1 returns a cause changeset" do
      cause = cause_setup()
      assert %Ecto.Changeset{} = Causes.change_cause(cause)
    end

    test "start date should be less than end date" do
      cause = cause_setup()
      invalid_date_attrs = %{end_date: "2007-08-18"}
      assert {:error, %Ecto.Changeset{}} = Causes.update_cause(cause, invalid_date_attrs)
      assert cause == Causes.get_cause!(cause.id)
    end
  end
end
