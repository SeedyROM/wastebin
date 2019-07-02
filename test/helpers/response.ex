defmodule Test.Response do
  @moduledoc """
  Allows Plug responses to be handled with more succinctly.
  """

  @doc """
  Decode the body of a JSON response.
  """
  def decode_json(json) do
    Poison.decode! json
  end
  
  @doc """
  Decode the body of a request into a string.
  """
  def decode_body(resp) do
    {_status, _headers, body} = resp
    decode_json(body)
  end

  @doc """
  Get only the body from an http response.
  """
  def get_body(resp) do
    {_status, _headers, body} = resp
    body    
  end

  @doc """
  Test if a Map contains keys.
  """
  def contains_keys(map, keys) do
    keys |> Enum.all?(&(Map.has_key?(map, &1)))
  end
end
