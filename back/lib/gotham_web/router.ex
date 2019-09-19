defmodule GothamWeb.Router do
  use GothamWeb, :router
  use PhoenixSwagger
  import Plug.Conn
  alias GothamWeb.Guardian


  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

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

  scope "/api", GothamWeb do
    pipe_through :api
    #get "/users/:id", UserController, :show
    get "/users", UserController, :show_params
    post "/users", UserController, :create
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
  
    post "/users/sign_in", UserController, :sign_in
    post "/users/sign_up", UserController, :sign_up
    post "/users/sign_out", UserController, :sign_out

    get "/workingtimes", WorkingTimeController, :index
    get "/workingtimes/:userID/:workingtimeID", WorkingTimeController, :show_one
    get "/workingtimes/:id", WorkingTimeController, :show_params
    post "/workingtimes/:id", WorkingTimeController, :create
    put "/workingtimes/:id", WorkingTimeController, :update
    delete "/workingtimes/:id", WorkingTimeController, :delete

    get "/clocks", ClocksController, :index
    get "/clocks/:id", ClocksController, :show
    post "/clocks/:id", ClocksController, :create


  end

  scope "/api", GothamWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/users/:id", UserController, :show
  end


  scope "/api/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :gotham, swagger_file: "swagger.json"
    end




  # Other scopes may use custom stacks.
  # scope "/api", GothamWeb do
  #   pipe_through :api
  # end
end
