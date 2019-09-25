defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :username, :string, null: false
      add :firstname, :string, null: false
      add :lastname, :string, null: false
      add :password, :string
      add :role_id, references(:roles, on_delete: :nothing), default: 1
      add :team, {:array, :integer}
      timestamps()
    end
     execute "INSERT INTO users (firstname, lastname, email, username, password, role_id, inserted_at, updated_at) VALUES ('yoann', 'abbes', 'yoann.abbes@gmail.com', 'admin', '#{Bcrypt.hash_pwd_salt("admin")}', 3, '#{DateTime.utc_now()}', '#{DateTime.utc_now()}');"
     execute "UPDATE users SET team = team || '{1}';"
  end
end
