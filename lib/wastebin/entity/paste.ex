defmodule Wastebin.Entity.Paste do
  use Ecto.Schema

  schema "paste" do
    field :filename, :string
    field :slug, :string
    field :uploaded_at, :utc_datetime, default: Ecto.DateTime.utc
  end
end