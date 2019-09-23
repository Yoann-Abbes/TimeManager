defmodule GothamWeb.WorkingTimeController do
  use GothamWeb, :controller
  use PhoenixSwagger

  alias Gotham.Work
  alias Gotham.Work.WorkingTime
  alias Gotham.Auth

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    workingtime = Work.list_workingtime()
    IO.inspect workingtime
    render(conn, "index.json", workingtime: workingtime)
  end

  def create(conn, %{"id" => id, "working_time" => working_time_params}) do
    user = Auth.get_user!(id)
    IO.inspect working_time_params
    with {:ok, %WorkingTime{} = working_time} <- Work.create_working_time(user, working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", working_time_path(conn, :show_params, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show_one(conn, %{"userID" => user_id, "workingtimeID" => wt_id}) do
    workingtime = Work.get_working_time_list_by_ids(user_id, wt_id)
    render(conn, "index.json", workingtime: workingtime)
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

    with {:ok, %WorkingTime{} = working_time} <- Work.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = Work.get_working_time!(id)
    with {:ok, %WorkingTime{}} <- Work.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end


def swagger_definitions do
  %{
    workingtime: swagger_schema do
      title "workingtime"
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


end
