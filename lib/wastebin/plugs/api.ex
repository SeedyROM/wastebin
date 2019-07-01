defmodule Wastebin.Plugs.API do
  use Plug.Router

  alias Wastebin.Repo
  alias Wastebin.Entity.Paste

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :match
  plug Plug.Parsers, parsers: [:json],
                     pass:  ["application/json"],
                     json_decoder: Poison
  plug :dispatch

  get "/" do
    changeset = Paste.changeset(%Paste{}, conn.body_params)

    {:ok, entity} = changeset |> Repo.insert
    payload = entity |> Poison.encode!
    
    send_resp(conn, 200, payload)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end