defmodule SingForNeedsWeb.CauseController do
  use SingForNeedsWeb, :controller

  alias SingForNeeds.Causes
  alias SingForNeeds.Causes.Cause

  action_fallback SingForNeedsWeb.FallbackController

  def index(conn, _params) do
    causes = Causes.list_causes()
    render(conn, "index.json", causes: causes)
  end

  def create(conn, %{"cause" => cause_params}) do
    with {:ok, %Cause{} = cause} <- Causes.create_cause(cause_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.cause_path(conn, :show, cause))
      |> render("show.json", cause: cause)
    end
  end

  def show(conn, %{"id" => id}) do
    cause = Causes.get_cause!(id)
    render(conn, "show.json", cause: cause)
  end

  def update(conn, %{"id" => id, "cause" => cause_params}) do
    cause = Causes.get_cause!(id)

    with {:ok, %Cause{} = cause} <- Causes.update_cause(cause, cause_params) do
      render(conn, "show.json", cause: cause)
    end
  end

  def delete(conn, %{"id" => id}) do
    cause = Causes.get_cause!(id)

    with {:ok, %Cause{}} <- Causes.delete_cause(cause) do
      send_resp(conn, :no_content, "")
    end
  end
end
