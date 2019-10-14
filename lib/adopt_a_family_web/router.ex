defmodule AdoptAFamilyWeb.Router do
  use AdoptAFamilyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdoptAFamilyWeb do
    pipe_through [:browser, AdoptAFamilyWeb.Plugs.Guest]

    resources "/register", UserController, only: [:new, :create]
    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", AdoptAFamilyWeb do
    pipe_through [:browser, AdoptAFamilyWeb.Plugs.Auth]

    get "/", PageController, :index
    resources "/profile", UserController, only: [:edit, :update, :delete]
    delete "/logout", SessionController, :delete
    resources "/families", FamilyController, except: [:edit, :update, :delete]
  end
end
