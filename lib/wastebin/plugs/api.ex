defmodule Wastebin.Plugs.API do
  import Ecto.Query

  alias Wastebin.Helpers
  use Helpers.JSONRouter
  use Helpers.Repo

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  get "/" do
    pastes = Repo.all(from p in Paste)
    payload = 
      %{pastes: pastes}
      |> Poison.encode!

    send_resp(conn, 200, payload)
  end

  post "/" do
    changeset = Paste.changeset(%Paste{}, conn.body_params)

    {:ok, paste} = changeset |> Repo.insert
    payload = %{paste: paste} |> Poison.encode!
    
    send_resp(conn, 201, payload)
  end

  get "/:id" do
    paste = Repo.one(
      from p in Paste,
        where: p.id == ^id
    )

    IO.inspect(paste)
    send_resp(conn, 200, "yes")
  end


end