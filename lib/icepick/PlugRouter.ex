defmodule Icepick.PlugRouter do

  use Plug.Router

  plug Plug.Parsers, parsers: [:json],
                     pass: ["*/*"],
                     json_decoder: Poison
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    ExStatsD.increment("icepick.inbound-requests.counter")
#    IO.inspect conn.params["_json"]
    send_resp(conn, 204, "")
    #req = Poison.Parser.parse!(body)
    #IO.puts inspect(req)
  end

  match _ do
    ExStatsD.increment("icepick.inbound-requests.invalid")
    send_resp(conn, 204, "")
  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http(
      __MODULE__,
      [acceptors: 100],
      port: 8000)
  end

end