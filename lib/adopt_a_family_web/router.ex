defmodule AdoptAFamilyWeb.Router do
  use AdoptAFamilyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdoptAFamilyWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, except: [:index, :show]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end
end
