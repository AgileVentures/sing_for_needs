defmodule SingForNeedsWeb.GithubDeployView do
  use Phoenix.LiveView

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <div class="">
      <div>
        <%= @deploy_step %>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, deploy_step: "Ready!")}
  end
end
