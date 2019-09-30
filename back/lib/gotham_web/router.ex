defmodule GothamWeb.Router do
  use GothamWeb, :router
  use PhoenixSwagger
  import Plug.Conn
  alias Gotham.Auth.Guardian

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
    plug GothamWeb.AuthPipeline
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
    get "/test", PageController, :test
  end


  scope "/api/users", GothamWeb do
    pipe_through :api

    post "/sign_in", UserController, :sign_in
    post "/sign_up", UserController, :sign_up
    delete "/sign_out", UserController, :sign_out
  end

  scope "/api/users", GothamWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/me", UserController, :show
    get "/", UserController, :index
    get "/team", UserController, :list_team
    get "/:id", UserController, :show_by_id
    post "/", UserController, :create
    post "/add_in_team", UserController, :add_in_team
    post "/remove_from_team", UserController, :remove_from_team
    put "/:id", UserController, :update
    delete "/:id", UserController, :remove
    
  end


  scope "/api/workingtimes", GothamWeb do
    pipe_through [:api, :jwt_authenticated]
    
    get "/", WorkingTimeController, :index
    get "/:userID/:workingtimeID", WorkingTimeController, :show_one
    get "/:id", WorkingTimeController, :show_params
    post "/:id", WorkingTimeController, :create
    put "/:id", WorkingTimeController, :update
    delete "/:id", WorkingTimeController, :remove
  end
  
  scope "/api/clocks", GothamWeb do
    pipe_through [:api, :jwt_authenticated]
    
    get "/", ClocksController, :index
    get "/:id", ClocksController, :show
    post "/:id", ClocksController, :create
    delete "/:id", ClocksController, :remove
  end

  scope "/api/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :gotham, swagger_file: "swagger.json"
    end




  # Other scopes may use custom stacks.
  # scope "/api", GothamWeb do
  #   pipe_through :api
  # end
end
