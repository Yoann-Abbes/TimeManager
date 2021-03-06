defmodule GothamWeb.WorkingTimeController do
  use GothamWeb, :controller
  use PhoenixSwagger

  alias Gotham.Work
  alias Gotham.Work.WorkingTime
  alias Gotham.Auth

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    workingtime = Work.list_workingtime()
    render(conn, "index.json", workingtime: workingtime)
  end

  def create(conn, %{"id" => id, "working_time" => working_time_params}) do
    user = Auth.get_user!(id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      with {:ok, %WorkingTime{} = working_time} <- Work.create_working_time(user, working_time_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", working_time_path(conn, :show_params, working_time))
        |> render("show.json", working_time: working_time)
      end
    else
      json(conn, "You are not allowed to delete this user.")
    end
  end

  def show_one(conn, %{"userID" => user_id, "workingtimeID" => wt_id}) do
    workingtime = Work.get_working_time_list_by_ids(user_id, wt_id)
    user = Auth.get_user!(workingtime.user_id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(user_id) in team)
     do
      render(conn, "index.json", workingtime: workingtime)
    else
      json(conn, "You are not allowed to delete this user.")
     end
  end


  def show_params(conn, %{"id" => id}) do
    params = conn.query_params

    if Map.has_key?(params, "start") and Map.has_key?(params, "end") do
      workingtime = Work.get_working_time_by_start_end(id, Map.get(params, "start"), Map.get(params, "end"))
      render(conn, "index.json", workingtime: workingtime)
    end
    if Map.has_key?(params, "start") and Map.has_key?(params, "end") == false do
      workingtime = Work.get_working_time_by_start(id, Map.get(params, "start"))
      render(conn, "index.json", workingtime: workingtime)
    end
    if Map.has_key?(params, "start") == false and Map.has_key?(params, "end") do
      workingtime = Work.get_working_time_by_end(id, Map.get(params, "end"))
      render(conn, "index.json", workingtime: workingtime)
    end
    workingtime = Work.get_working_time_list_by(id)
    render(conn, "index.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = Work.get_working_time!(id)
    user = Auth.get_user!(working_time.user_id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do

      with {:ok, %WorkingTime{} = working_time} <- Work.update_working_time(working_time, working_time_params) do
        render(conn, "show.json", working_time: working_time)
      end
    else
      json(conn, "You are not allowed to delete this user.")
    end
  end

  def remove(conn, %{"id" => id}) do
    working_time = Work.get_working_time!(id)
    user = Auth.get_user!(working_time.user_id)
    current_user = Guardian.Plug.current_resource(conn)
    current_role_id = Integer.to_string(current_user.role_id)
    current_id = Integer.to_string(current_user.id)
    team = current_user.team

    if current_user.id == user.id
    || current_user.role_id == 3
    || (current_user.role_id == 2 && String.to_integer(id) in team)
     do
      with {:ok, %WorkingTime{}} <- Work.delete_working_time(working_time) do
        send_resp(conn, :no_content, "")
      end
    else
      json(conn, "You are not allowed to delete this user.")
    end
  end


def swagger_definitions do
  %{
    workingtime: swagger_schema do
      title "Workingtime"
      description "A user workingtime"
      properties do
        start :datetime, "Users start working", required: true
        eend :datetime, "Users end working", required: true
        user_id :integer, "Users id", required: true
      end
      example %{
        start: "2019-12-12 09:00:00",
        end: "2019-12-12 18:00:00",
        user_id: 42
      }
    end
    }
  end


  swagger_path :create do
    post "/"
    summary "Add a new workingtime"
    description "Add new workingtime"
    parameters do
      user :body, Schema.ref(:workingtime), "workingtime data to record", required: true
    end
    response 201, "Ok", Schema.ref(:workingtime)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end
  
  swagger_path :show_one do
    get "/:userId/:workingtimeId"
    summary "Show current users data"
    description "Show current users data"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :show_params do
    get "/:userId/:workingtimeId"
    summary "Show current users data"
    description "Show current users data"
    response 201, "Ok"
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end


  swagger_path :update do
    patch "/:userId"
    summary "Update an existing users workingtime"
    description "Update an existing users workingtime"
    parameters do
      start :path, :datetime, "Users start date", required: false
      eend :path, :datetime, "Users end date", required: false
    end
    response 201, "Ok", Schema.ref(:workingtime)
    response 422, "Unprocessable Entity", Schema.ref(:Error)
  end

  swagger_path :remove do
    delete "/:userId"
    summary "Delete a users workingtime"
    description "Delete a users workingtime"
    parameters do
      id :path, :integer, "The user id", required: true
    end
    response 204, "No content"
    response 404, "Not found", Schema.ref(:Error)
  end
end
