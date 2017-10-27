defmodule SingForNeedsWeb.PageController do
  use SingForNeedsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
