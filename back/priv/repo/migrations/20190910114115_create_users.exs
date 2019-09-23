defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :password, :string
      add :roleId, references(:roles, on_delete: :nothing), default: 1
    end
    
    execute "INSERT INTO users (firstname, lastname, email, username, password, roleId) VALUES ('yoann', 'abbes', 'yoann.abbes@gmail.com', 'admin', 'admin', 3);"

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
    create unique_index(:users, [:firstname])
    create unique_index(:users, [:lastname])
    create unique_index(:password, [:password])
    create unique_index(:roleId, [:roleId])
  end
end
