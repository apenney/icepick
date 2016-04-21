defmodule Icepick.PlugRouter do

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    ExStatsD.increment("icepick.inbound-requests.counter")
    send_resp(conn, 204, "")
    #req = Poison.Parser.parse!(body)
    #IO.puts inspect(req)
  end

  match _ do
    IO.puts "Received unmatched request!"
    send_resp(conn, 204, "")
  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http(
      __MODULE__,
      [acceptors: 1000],
      port: 8000)
  end

end