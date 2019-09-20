defmodule Gotham.Roles do
  use Ecto.Schema
  import Ecto.Changeset


  schema "roles" do
    field :label, :string

  end

  @doc false
  def changeset(roles, attrs) do
    roles
    |> cast(attrs, [:label])
    |> validate_required([:label])
  end
end
