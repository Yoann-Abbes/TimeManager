defmodule Gotham.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :username, :string
    field :lastname, :string
    field :firstname, :string
    field :password, :string
    field :role_id, :id, default: 1
    field :team, {:array, :integer}
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :lastname, :firstname, :password, :role_id])
    |> validate_required([:email, :username, :lastname, :firstname, :password, :role_id])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    #|> unique_constraint(:role_id)
  end
end
