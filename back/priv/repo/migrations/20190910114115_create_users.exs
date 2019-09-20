defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :firstname, :string, null: false
      add :lastname, :string, null: false

    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
    create unique_index(:users, [:firstname])
    create unique_index(:users, [:lastname])
  end
end
