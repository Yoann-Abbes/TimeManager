defmodule Gotham.Work.WorkingTime do

  use Ecto.Schema
  import Ecto.Changeset


  schema "workingtime" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
  end
end
