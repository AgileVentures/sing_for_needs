defmodule SingForNeedsWeb.PageController do
  use SingForNeedsWeb, :controller
alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, SingForNeedsWeb.GithubDeployView, session: %{})
  end
end
