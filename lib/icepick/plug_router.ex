defmodule Icepick.PlugRouter do

  use Plug.Router

  plug Plug.Parsers, parsers: [:json],
                     pass: ["*/*"],
                     json_decoder: Poison

  plug Icepick.PlugRequest

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    ExStatsD.increment("icepick.inbound-requests.counter")
    IO.inspect conn.private[:request]
    send_resp(conn, 204, "")
  end

  match _ do
    ExStatsD.increment("icepick.inbound-requests.invalid")
    send_resp(conn, 204, "")
  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http(
      __MODULE__,
      [acceptors: 1000, max_keepalive: :infinity, port: 8000],
      [acceptors: 1000, port: 8000])
  end

end