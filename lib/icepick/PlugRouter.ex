defmodule Icepick.PlugRouter do

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    #req = Poison.Parser.parse!(body)
    #IO.puts inspect(req)
    ExStatsD.increment("icepick.inbound-requests.counter")
    send_resp(conn, 204, "")
  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http __MODULE__, []
  end

end