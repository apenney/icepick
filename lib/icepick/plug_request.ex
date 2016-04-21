defmodule Icepick.PlugRequest do

  import Plug.Conn

  def init(options), do: options

  def call(%Plug.Conn{params: json} = conn, opts) do
    put_private(conn, :request, Icepick.Request.from_json(json))
  end
  
end