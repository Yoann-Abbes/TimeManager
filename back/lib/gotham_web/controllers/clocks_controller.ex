defmodule GothamWeb.ClocksController do
  use GothamWeb, :controller
  use PhoenixSwagger

  alias Gotham.Time
  alias Gotham.Time.Clocks
  alias Gotham.Work
  alias Gotham.Work.WorkingTime
  

  alias Gotham.Auth

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    clocks = Time.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"id" => id, "clocks" => clocks_params}) do

    user = Auth.get_user!(id)
    time = Map.get(clocks_params, "time")
    if Map.get(clocks_params, "status") == true do
      with {:ok, %Clocks{} = clocks} <- Time.create_clocks(user, clocks_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", clocks_path(conn, :show, clocks))
        |> render("show.json", clocks: clocks)
      end
      else if Map.get(clocks_params, "status") == false do

        time_clock = Time.get_time_clocks_by!(id, "true")
        clocks = Time.get_clocks_by!(id, "true")
        p = NaiveDateTime.to_string(NaiveDateTime.truncate(Enum.at(time_clock, 0), :second))
        Work.create_working_time(user, %{"end" => time, "start" => p})
        Time.update_clocks(Enum.at(clocks, 0), %{"status" => "false", "time" => time})
        render(conn, "index.json", clocks: clocks)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    clocks = Time.get_clocks_by!(id, true)
    render(conn, "index.json", clocks: clocks)
  end

  def show_d(conn, %{"email" => email}) do
    clocks = Time.get_clocks!(email)
    render(conn, "show.json", clocks: clocks)
  end

  def update(conn, %{"id" => id, "clocks" => clocks_params}) do
    clocks = Time.get_clocks!(id)

    with {:ok, %Clocks{} = clocks} <- Time.update_clocks(clocks, clocks_params) do
      render(conn, "show.json", clocks: clocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    clocks = Time.get_clocks!(id)
    with {:ok, %Clocks{}} <- Time.delete_clocks(clocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
