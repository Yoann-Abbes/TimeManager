defmodule GothamWeb.ClocksView do
  use GothamWeb, :view
  alias GothamWeb.ClocksView
  alias GothamWeb.WorkingTimeView

  def render("index.json", %{clocks: clocks}) do
    %{data: render_many(clocks, ClocksView, "clocks.json")}
  end

  def render("index_wt.json", %{working_time: working_time}) do
    %{data: render_many(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("show.json", %{clocks: clocks}) do
    %{data: render_one(clocks, ClocksView, "clocks.json")}
  end

  def render("clocks.json", %{clocks: clocks}) do
    %{id: clocks.id,
      time: clocks.time,
      status: clocks.status,
      user_id: clocks.user_id
    }
  end
end
