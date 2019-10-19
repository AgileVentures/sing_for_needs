defmodule SingForNeedsWeb.CauseView do
  use SingForNeedsWeb, :view
  alias SingForNeedsWeb.CauseView

  def render("index.json", %{causes: causes}) do
    %{data: render_many(causes, CauseView, "cause.json")}
  end

  def render("show.json", %{cause: cause}) do
    %{data: render_one(cause, CauseView, "cause.json")}
  end

  def render("cause.json", %{cause: cause}) do
    %{id: cause.id,
      name: cause.name,
      description: cause.description,
      end_date: cause.end_date}
  end
end
