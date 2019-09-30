defmodule GothamWeb.UserController do
  use GothamWeb, :controller
  use PhoenixSwagger
  import Bcrypt


  alias Gotham.{Users, Repo, ErrorView}
  alias Gotham.Guardian
  alias Gotham.Auth
  alias Gotham.Auth.User

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    users = Auth.list_users()
    if user.role_id == 1 do
      json(conn, "You have to be Manager.")
    end 
    render(conn, "index.json", users: users)
  end

  def show_by_id(conn, %{"id" => id}) do
    current_user = Guardian.Plug.current_resource(conn)
    current_id = Integer.to_string(current_user.id)
    user = Auth.get_user!(id)
    
    if current_id == id || current_id == 3 do
        render(conn, "show.json", user: user)
    end
      json(conn, "You have to be Manager.") 
  end


  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def add_in_team(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)

    IO.inspect user
    if user.role_id == 3 || user.role_id == 2 do
      Auth.add_member_to_team(user, id)
      user = Auth.get_user!(user.id)
      render(conn, "show.json", user: user)
    end
    json(conn, "Unauthorized action")
  end

  def remove_from_team(conn, %{"id" => id}) do
    user = Guardian.Plug.current_resource(conn)

    if user.role_id == 3 || user.role_id == 2 do
      Auth.remove_member_from_team(user, id)
      user = Auth.get_user!(user.id)
      render(conn, "show.json", user: user)
    end
    json(conn, "Unauthorized action")
  end


  def list_team(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.puts "-------------"

    if user.role_id == 3 || user.role_id == 2 do
      json(conn, user.team)
    else
     {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
     user = Guardian.Plug.current_resource(conn)
     conn |> render("show.json", user: user)
  end

  # def show_params(conn, _params) do
  #   #params = conn.query_params

  #   users = Auth.list_users()
  #   render(conn, "index.json", users: users)

  #   # if Map.has_key?(params, "email") and Map.has_key?(params, "username") do
  #   #   user = Auth.get_user_by!(Map.get(params, "email"), Map.get(params, "username"))
  #   #   conn |> render(conn, "show.json", user: user)
  #   # end
  # end

  def update(conn, %{"id" => id, "user" => user_params}) do

    user = Auth.get_user!(id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team
    
    if Map.has_key?(user_params, "role_id") && current_user.role_id !== 3 do  
      json(conn, "Only General Manager can promote.")
    else
       if current_user.id == user.id
         || current_user.role_id == 3
         || (current_user.role_id == 2 && String.to_integer(id) in team)
          do
        with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
          render(conn, "show.json", user: user)
        end
      end
    end
    json(conn, "Unauthorized action")
  end

  def remove(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      with {:ok, %User{}} <- Auth.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    else
      json(conn, "You are not allowed to delete this user.")
    end
  end

  def sign_in(conn, %{"user" => user_params}) do
    
    username = Map.get(user_params, "username")
    password = Map.get(user_params, "password")
    case Auth.token_sign_in(username, password) do
    {:ok, token, _claims} ->
      conn |> render("jwt.json", jwt: token)
    _ ->
      {:error, :unauthorized}
    end
  end

  def sign_up(conn, %{"user" => user_params}) do

    if Map.has_key?(user_params, "email") 
      and Map.has_key?(user_params, "firstname")
      and Map.has_key?(user_params, "lastname")
      and Map.has_key?(user_params, "username")
      and Map.has_key?(user_params, "password") do

        user_params = Map.replace!(user_params, "password", Bcrypt.hash_pwd_salt(Map.get(user_params, "password")))
        with {:ok, %User{} = user} <- Auth.create_user(user_params) do
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      end
    end
  end

  def sign_out(conn, _params) do
    
    token = Enum.at(get_req_header(conn, "x-xsrf-token"), 0)
    {:ok, claims} = Gotham.Guardian.revoke(token)
      send_resp(conn, :no_content, "")
  end

  def swagger_definitions do
    %{
      Users: swagger_schema do
        title "Users"
        description "A user of the application"
        properties do
          username :string, "Users name", required: true
          email :string, "Users email", required: true
          firstname :string, "Users firstname", required: true
          lastname :string, "Users lastname", required: true
          password :string, "Users password", required: true
          role_id :integer, "Users role Id"
          team :integer, "Ids of users, only for managers"
        end
        example %{
          username: "test",
          firstname: "john",
          lastname: "doe",
          password: "2uto3ihg]1081+_92752'",
          email: "test@123.com",
          role_id: "2",
          team: "[1, 2, 3]"
        }
       end,
      Error: swagger_schema do
      title "Errors"
      description "Error responses from the API"
      properties do
        error :string, "The message of the error raised", required: true
      end
    end
    }
  end
  
  swagger_path :create do
    post "/"
    summary "Add a new user"
    description "Add new user"
    parameters do
      user :body, Schema.ref(:Users), "User data to record", required: true
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end
  
  swagger_path :index do
    get "/"
    summary "Show all users data"
    description "Show all users data"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end


  swagger_path :show do
    get "/me"
    summary "Show current users data"
    description "Show current users data"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :show_by_id do
    get "/:id"
    summary "Show users data by id"
    description "Show users data by id"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :list_team do
    get "/team"
    summary "List the current user team"
    description "List the current user team"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end


  swagger_path :sign_in do
    post "/sign_in"
    summary "Sign in with credentials"
    description "Sign in with credentials"
    parameters do
    username :path, :string, "username", required: true
    passowrd :path, :string, "password", required: true
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :sign_up do
    post "/sign_up"
    summary "Create a new user account"
    description "Create a new user account"
    parameters do
    tracker :body, Schema.ref(:Users), "User data to record"
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :sign_out do
    delete "/sign_out"
    summary "Sign out the current user"
    description "Sign out the current user"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end
  
  swagger_path :update do
    patch "/:id"
    summary "Update an existing user"
    description "Update an existing user"
    parameters do
      username :path, :string, "Users name", required: false
      email :path, :string, "Users email", required: false
      firstname :path, :string, "Users firstname", required: false
      lastname :path, :string, "Users lastname", required: false
      password :path, :string, "Users password", required: false
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :add_in_team do
    post "/add_in_team"
    summary "Add a user to a manager's team"
    description "Add a user to a manager's team"
    parameters do
      id :path, :integer, "Users id", required: true
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :remove_from_team do
    post "/remove_from_team"
    summary "Remove a user from a manager's team"
    description "Remove a user from a manager's team"
    parameters do
      id :path, :integer, "Users id", required: true
    end
    response 201, "Ok", Schema.ref(:Users)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :delete do
    delete "/:id"
    summary "Delete a user"
    description "Delete a user"
    parameters do
      id :path, :integer, "The uuid of the activity", required: true
    end
    response 204, "No content"
    response 404, "Not found", Schema.ref(:Error)
  end
end
