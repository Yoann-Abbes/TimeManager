defmodule GothamWeb.UserController do
  use GothamWeb, :controller
  use PhoenixSwagger
  import Bcrypt

  
  alias Gotham.Auth
  alias Gotham.Auth.User

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    users = Auth.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Auth.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def show_params(conn, %{}) do
    params = conn.query_params

    if Map.has_key?(params, "email") and Map.has_key?(params, "username") do
      user = Auth.get_user_by!(Map.get(params, "email"), Map.get(params, "username"))
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Auth.get_user!(id)

    with {:ok, %User{} = user} <- Auth.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Auth.get_user!(id)
    with {:ok, %User{}} <- Auth.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"user" => user_params}) do
    
    if Map.has_key?(user_params, "email") 
      and Map.has_key?(user_params, "username")
      and Map.has_key?(user_params, "password") do
      user = Auth.get_user_by!(Map.get(user_params, "email"), Map.get(user_params, "username"))
        if Bcrypt.verify_pass(Map.get(user_params, "password"), user.password) do
          role = Auth.get_role!(user.roleId)          
          extra_claims = %{"id" => user.id, "role" => role}
          token = Gotham.Token.generate_and_sign!(extra_claims)
          {:ok, claims} = Gotham.Token.verify_and_validate(token)
          with {:ok, %User{} = user} <- user = Auth.update_user(user, %{"token" => token}) do
            json(conn, %{"token" => token})
        end
      end
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
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    end
  end

  def sign_out(conn, %{}) do
    params = conn.query_params
    userId = Map.get(params, "id")
    with {:ok, %User{}} <- Auth.delete_user_token(userId) do
      send_resp(conn, :no_content, "")
    end
  end

  def swagger_definitions do
    %{
      users: swagger_schema do
        title "users"
        description "A user of the application"
        properties do
          username :string, "Users name", required: true
          email :string, "Users email", required: true
        end
        example %{
          username: "test",
          email: "test@123.com"
        }
      end
    }
  end

  swagger_path :show do
      get "/api/users/:id"
      paging size: "page[size]", number: "page[number]"
      response 200, "OK", Schema.ref(:Users)
    end



end
