defmodule Gotham.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :label, :string
    end
    execute "INSERT INTO roles (label) VALUES ('User');"
    execute "INSERT INTO roles (label) VALUES ('Manager');"
    execute "INSERT INTO roles (label) VALUES ('General_Manager');"
  end
end
