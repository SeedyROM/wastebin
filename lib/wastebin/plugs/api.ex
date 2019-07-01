defmodule Wastebin.Plugs.API do
  use Plug.Router

  alias Wastebin.Repo
  alias Wastebin.Entity.Paste

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :match
  plug :dispatch

  get "/" do
    changeset = Paste.changeset(
      %Paste{},
      %{
        "filename" => "fuck.png",
      }
    )

    changeset |> Repo.insert

    send_resp(conn, 200, "Hello Plug")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end