defmodule Wastebin.Plugs.APITest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Test.CaseHelpers

  @api_opts API.init([])
  @valid_test_filename "test-filename.jpg"
  @valid_paste_body %{
    :filename => @valid_test_filename
  }
  @required_fields [
    "id", 
    "filename", 
    "slug"
  ]

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wastebin.Repo)
    {:ok, entity} =
      Paste.changeset(%Paste{}, @valid_paste_body)
      |> Repo.insert

    {:ok, entity: entity}
  end

  describe "should 404 on invalid pastes" do    
    test "404" do
      conn = 
        :get
        |> conn("/#{Ecto.UUID.generate()}")
        |> API.call(@api_opts)
  
      assert conn.state == :sent
      assert conn.status == 404
  
      body = sent_resp(conn) |> decode_body
      assert body["message"] == "Not Found"
    end
  
    test "can list pastes" do
      conn = 
        :get
        |> conn("/")
        |> API.call(@api_opts)
      
      assert conn.state == :sent
      assert conn.status == 200

      body = sent_resp(conn) |> decode_body
      assert length(body["pastes"]) == 1
    end

    test "can show single paste information", %{entity: entity} do
      IO.inspect(entity)

      conn =
        :get
        |> conn("/#{entity.id}")
        |> API.call(@api_opts)

      assert conn.state == :sent
      assert conn.status == 200
    end

    test "can create paste" do
      conn = 
        :post
        |> conn("/", @valid_paste_body)
        |> API.call(@api_opts)
  
      assert conn.state == :sent
      assert conn.status == 201
  
      body = sent_resp(conn) |> decode_body

      has_valid_keys = contains_keys(body["paste"], @required_fields)
      assert has_valid_keys == true
      
      assert body["paste"]["filename"] == @valid_test_filename
    end
  end
end