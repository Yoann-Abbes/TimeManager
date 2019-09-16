defmodule GothamWeb.WorkingTimeView do
  use GothamWeb, :view
  alias GothamWeb.WorkingTimeView

  def render("index.json", %{workingtime: workingtime}) do
    %{data: render_many(workingtime, WorkingTimeView, "working_time.json")}
  end

  def render("show.json", %{working_time: working_time}) do
    %{data: render_one(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("working_time.json", %{working_time: working_time}) do
    %{id: working_time.id,
      start: working_time.start,
      end: working_time.end}
  end
end
