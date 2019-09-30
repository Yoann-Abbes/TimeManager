defmodule GothamWeb.ClocksController do
  use GothamWeb, :controller
  use PhoenixSwagger

  alias Gotham.{Users, Repo, ErrorView}
  alias Gotham.Guardian
  alias Gotham.Time
  alias Gotham.Time.Clocks
  alias Gotham.Work
  alias Gotham.Auth
  alias Gotham.Auth.User
  alias Gotham.Work.WorkingTime
  

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    clocks = Time.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"id" => id, "clocks" => clocks_params}) do

    user = Auth.get_user!(id)
    time = Map.get(clocks_params, "time")

    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      if Map.get(clocks_params, "status") == true do
        with {:ok, %Clocks{} = clocks} <- Time.create_clocks(user, clocks_params) do
          conn
          |> put_status(:created)
          |> put_resp_header("location", clocks_path(conn, :show, clocks))
          |> render("show.json", clocks: clocks)
        end
        else if Map.get(clocks_params, "status") == false do
          IO.puts "------------------"
          time_clock = Time.get_time_clocks_by!(id, "true")
          IO.inspect time_clock
          clocks = Time.get_clocks_by!(id, "true")
          IO.inspect clocks
          p = NaiveDateTime.to_string(NaiveDateTime.truncate(Enum.at(time_clock, 0), :second))
          Work.create_working_time(user, %{"end" => time, "start" => p})
          Time.update_clocks(Enum.at(clocks, 0), %{"status" => "false", "time" => time})
          clocks = Enum.at(Time.get_clocks_by!(id, "false"), 0)
          IO.inspect clocks
          
          render(conn, "show.json", clocks: clocks)
        end
      end
    end
    json(conn, "You have to be Manager.") 
  end

  def show(conn, %{"id" => id}) do
    clocks = Time.get_all_clocks_by_user_id!(id)
    user = Auth.get_user!(id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      render(conn, "index.json", clocks: clocks)
     end
     json(conn, "You have to be Manager.") 
  end

  def remove(conn, %{"id" => id}) do
    clocks = Time.get_clocks!(id)
    user = Auth.get_user!(clocks.user_id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      with {:ok, %Clocks{}} <- Time.delete_clocks(clocks) do
        send_resp(conn, :no_content, "")
      end
    end
    json(conn, "You have to be Manager.") 
  end

  def swagger_definitions do
  %{
    clocks: swagger_schema do
      title "Clocks"
      description "A user clocks"
      properties do
        time :datetime, "Users start working", required: true
        status :status, "Working or not status", required: true
        user_id :integer, "Users id", required: true
      end
      example %{
        time: "2019-12-12 09:00:00",
        status: "true",
        user_id: 42
      }
    end
    }
  end


  swagger_path :create do
    post "/"
    summary "Clocks in or Clocks out"
    description "Store the start when a user clock in, creates a workingtime when clock out"
    parameters do
      user :body, Schema.ref(:clocks), "clocks data to record", required: true
    end
    response 201, "Ok", Schema.ref(:clocks)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end
  
  swagger_path :show do
    get "/:userId"
    summary "Show current users data"
    description "Show current users data"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end
end
