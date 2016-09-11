defmodule Wood.Router do
  use Wood.Web, :router

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

  scope "/", Wood do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/rooms", RoomController, :index
    get "/rooms/new", RoomController, :new
    post "/rooms", RoomController, :create
    get "/rooms/:id", RoomController, :show
    delete "/rooms/:id", RoomController, :delete
    get "/registrations/new", RegistrationController, :new
    post "/registrations", RegistrationController, :create
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Wood do
  #   pipe_through :api
  # end
end
