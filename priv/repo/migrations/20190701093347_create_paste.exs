defmodule Wastebin.Repo.Migrations.CreatePaste do
  use Ecto.Migration

  def change do
    create table(:paste, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :filename, :string, null: false
      add :slug, :string, null: false
      timestamps()
    end
  end
end
