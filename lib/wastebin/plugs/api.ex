defmodule Wastebin.Plugs.API do
  import Ecto.Query
  use Plug.Router

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

    {:ok, entity} = changeset |> Repo.insert
    payload = %{paste: entity} |> Poison.encode!
    
    send_resp(conn, 200, payload)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end