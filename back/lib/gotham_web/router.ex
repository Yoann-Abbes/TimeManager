defmodule GothamWeb.Router do
  use GothamWeb, :router
  use PhoenixSwagger
  import Plug.Conn
  alias GothamWeb.Guardian

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

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Gotham"
      }
    }
  end  

  scope "/", GothamWeb do
    pipe_through :browser
    get "/", PageController, :index
  end


  scope "/api/users", GothamWeb do
    pipe_through :api

    get "/", UserController, :show_params
    post "/", UserController, :create
    put "/:id", UserController, :update
    delete "/:id", UserController, :delete
    post "/sign_in", UserController, :sign_in
    post "/sign_up", UserController, :sign_up
    post "/sign_out", UserController, :sign_out

  end

  scope "/api/users", MyApiWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/me", UserController, :show
  end


  scope "/api/workingtimes", GothamWeb do
    pipe_through :api
    
    get "/", WorkingTimeController, :index
    get "/:userID/:workingtimeID", WorkingTimeController, :show_one
    get "/:id", WorkingTimeController, :show_params
    post "/:id", WorkingTimeController, :create
    put "/:id", WorkingTimeController, :update
    delete "/:id", WorkingTimeController, :delete
  end
  
  scope "/api/clocks", GothamWeb do
    pipe_through :api
    
    get "/", ClocksController, :index
    get "/:id", ClocksController, :show
    post "/:id", ClocksController, :create
  end

  scope "/api/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :gotham, swagger_file: "swagger.json"
    end




  # Other scopes may use custom stacks.
  # scope "/api", GothamWeb do
  #   pipe_through :api
  # end
end
