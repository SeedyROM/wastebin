defmodule Test.Response do
  def decode_json(json) do
    Poison.decode! json
  end
  
  def decode_body(resp) do
    {_status, _headers, body} = resp
    decode_json(body)
  end

  def contains_keys(map, keys) do
    keys |> Enum.all?(&(Map.has_key?(map, &1)))
  end
end
