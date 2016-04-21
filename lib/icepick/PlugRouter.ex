defmodule Icepick.PlugRouter do

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    ExStatsD.increment("icepick.inbound-requests.counter")
    case Plug.Conn.read_body(conn) do
      {:ok, body, conn} ->
        ExStatsD.increment("icepick.inbound-requests.parsed.counter")
        req = Poison.Parser.parse!(body)
      {:error, :timeout} ->
        ExStatsD.increment("icepick.inbound-requests.timeout.counter")
    end
    send_resp(conn, 204, "")
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