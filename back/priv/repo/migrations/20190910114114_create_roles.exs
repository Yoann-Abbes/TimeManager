defmodule Gotham.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  
  def change do
  timestamp = DateTime.utc_now()
    create table(:roles) do
      add :label, :string
      timestamps()
    end
    execute "INSERT INTO roles (label, inserted_at, updated_at) VALUES ('User', '#{timestamp}', '#{timestamp}');"
    execute "INSERT INTO roles (label, inserted_at, updated_at) VALUES ('Manager', '#{timestamp}', '#{timestamp}');"
    execute "INSERT INTO roles (label, inserted_at, updated_at) VALUES ('General_Manager', '#{timestamp}', '#{timestamp}');"
  end
  
end
