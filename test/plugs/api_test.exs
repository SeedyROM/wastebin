defmodule Wastebin.Plugs.APITest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Wastebin.Plugs.API

  @opts API.init([])

  test "404" do
    conn = conn(:get, "/xxFakePagexx")
      |> API.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404

    {_, _, body} = sent_resp(conn)
    assert body == "Not Found"
  end

  test "initial plug returns back valid message" do
    conn = 
      :get
      |> conn("/")
      |> API.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200

    {_, _, body} = sent_resp(conn)
    assert body == "Hello Plug"
  end
end