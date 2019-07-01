defmodule Wastebin.Entity.Paste do
  use Ecto.Schema
  import Ecto.Changeset
  
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "paste" do
    field :filename, :string
    field :slug, :string
    timestamps()
  end

  defp hash_slug(filename) do
    :crypto.hash(:md5, filename)
      |> Base.encode16(case: :lower)
  end
  
  defp set_slug(changeset) do
    filename = get_field(changeset, :filename)
    now = Ecto.DateTime.utc()

    slug =
      Enum.join([filename, now])
      |> hash_slug

    put_change(changeset, :slug, slug)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:filename])
    |> validate_required([:filename])
    |> set_slug
  end
end