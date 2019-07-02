defmodule Wastebin.Plugs.APITest do
  use ExUnit.Case, async: true
  use Plug.Test
  use Test.CaseHelpers

  @opts API.init([])

  @valid_test_filename "test-filename.jpg"
  @valid_paste_body %{
    :filename => @valid_test_filename
  }
  @invalid_paste_body %{
    :blah => :nah
  }

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Wastebin.Repo)
    {:ok, _entity} =
      Paste.changeset(%Paste{}, @valid_paste_body)
      |> Repo.insert

    :ok
  end

  @required_fields [
    "id", 
    "filename", 
    "slug",
  ]

  describe "initial brain tests" do    
    test "404" do
      conn = 
        :get
        |> conn("/xxFakePagexx")
        |> API.call(@opts)
  
      assert conn.state == :sent
      assert conn.status == 404
  
      body = sent_resp(conn) |> get_body
      assert body == "Not Found"
    end
  
    test "can list pastes" do
      conn = 
        :get
        |> conn("/")
        |> API.call(@opts)
      
      assert conn.state == :sent
      assert conn.status == 200

      body = sent_resp(conn) |> decode_body

      assert body["pastes"].length == 1
    end

    test "can create paste" do
      conn = 
        :post
        |> conn("/", @valid_paste_body)
        |> API.call(@opts)
  
      assert conn.state == :sent
      assert conn.status == 200
  
      body = sent_resp(conn) |> decode_body
      has_valid_keys = contains_keys(body, @required_fields)
      assert has_valid_keys == true
      
      assert body["filename"] == @valid_test_filename
    end
  end
end