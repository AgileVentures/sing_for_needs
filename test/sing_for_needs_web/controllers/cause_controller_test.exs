defmodule SingForNeedsWeb.CauseControllerTest do
  @moduledoc """
    Cause controller
  """
  use SingForNeedsWeb.ConnCase

  alias SingForNeeds.Causes
  alias SingForNeeds.Causes.Cause

  @create_attrs %{
    description: "some description",
    end_date: ~N[2010-04-17 14:00:00],
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    end_date: ~N[2011-05-18 15:01:01],
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, end_date: nil, name: nil}

  def fixture(:cause) do
    {:ok, cause} = Causes.create_cause(@create_attrs)
    cause
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all causes", %{conn: conn} do
      conn = get(conn, Routes.cause_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create cause" do
    test "renders cause when data is valid", %{conn: conn} do
      conn = post(conn, Routes.cause_path(conn, :create), cause: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.cause_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "end_date" => "2010-04-17T14:00:00",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.cause_path(conn, :create), cause: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update cause" do
    setup [:create_cause]

    test "renders cause when data is valid", %{conn: conn, cause: %Cause{id: id} = cause} do
      conn = put(conn, Routes.cause_path(conn, :update, cause), cause: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.cause_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "end_date" => "2011-05-18T15:01:01",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, cause: cause} do
      conn = put(conn, Routes.cause_path(conn, :update, cause), cause: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete cause" do
    setup [:create_cause]

    test "deletes chosen cause", %{conn: conn, cause: cause} do
      conn = delete(conn, Routes.cause_path(conn, :delete, cause))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.cause_path(conn, :show, cause))
      end
    end
  end

  defp create_cause(_) do
    cause = fixture(:cause)
    {:ok, cause: cause}
  end
end
