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

  scope "/", SingForNeedsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", SingForNeedsWeb do
    pipe_through :api

    resources "/artists", ArtistController, except: [:new, :edit]
    resources "/causes", CauseController, except: [:new, :edit]
  end
end
