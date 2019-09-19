defmodule Gotham.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :username, :string
    field :lastname, :string
    field :firstname, :string
    field :password, :string
    field :roleId, :id, default: 1
    field :token, :string

  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :username, :lastname, :firstname, :password, :roleId])
    |> validate_required([:email, :username, :lastname, :firstname, :password, :roleId])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
