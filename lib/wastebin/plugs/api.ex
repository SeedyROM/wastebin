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
    found = Repo.get(Paste, id)
    case found do
      nil -> send_resp(conn, 404, %{message: "Not Found"} |> Poison.encode!)
      _ -> send_resp(conn, 200, %{paste: found} |> Poison.encode!)
    end
  end
end