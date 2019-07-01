defmodule Wastebin.Plugs.APITest do
  use ExUnit.Case, async: true
  use Plug.Test
  
  alias Wastebin.Plugs.API
  import Test.Response

  @opts API.init([])

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wastebin.Repo)
  end

  @required_fields [
    "id", 
    "filename", 
    "slug",
  ]

  describe "initial brain tests" do    
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
        |> conn("/", %{
          "filename" => "test-filename.file",
        })
        |> API.call(@opts)
  
      assert conn.state == :sent
      assert conn.status == 200
  
      body = sent_resp(conn) |> decode_body

      has_valid_keys = contains_keys(body, @required_fields)
      assert has_valid_keys == true
      assert body["filename"] == "test-filename.file"
    end
  end
end