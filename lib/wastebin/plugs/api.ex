defmodule Wastebin.Plugs.API do
  use Plug.Router

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello Plug")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end