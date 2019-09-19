defmodule Gotham.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
      add :roleId, references(:roles, on_delete: :nothing), default: 1
      add :token, :string

    end
  end
end
