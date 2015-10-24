defmodule Icepick.PlugRouter do

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http __MODULE__, []
  end

end