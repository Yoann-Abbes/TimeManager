defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
      add :roleId, references(:roles, on_delete: :nothing), default: 1
    end
    execute "INSERT INTO users (firstname, lastname, email, username, password, roleId) VALUES ('yoann', 'abbes', 'yoann.abbes@gmail.com', 'admin', 'admin', 3);"
  end
end
