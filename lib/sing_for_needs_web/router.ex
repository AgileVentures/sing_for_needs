defmodule SingForNeedsWeb.Router do
  use SingForNeedsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:3000", "http://127.0.0.1:3000"]
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: SingForNeedsWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: SingForNeedsWeb.Schema.Schema,
      socket: SingForNeedsWeb.UserSocket,
      interface: :simple
  end

  # Other scopes may use custom stacks.
end
