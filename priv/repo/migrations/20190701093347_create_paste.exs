defmodule Wastebin.Repo.Migrations.CreatePaste do
  use Ecto.Migration

  def change do
    create table(:paste) do
      add :filename, :string, null: false
      add :slug, :string, null: false
      add :uploaded_at, :utc_datetime, null: false
    end
  end
end
