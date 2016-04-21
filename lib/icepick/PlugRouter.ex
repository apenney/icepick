defmodule Icepick.PlugRouter do

  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Icepick is now using Plug!")
  end

  post "/supply-partners/mopub" do
    {:ok, body, conn} = case Plug.Conn.read_body(conn) do
      {:ok, body, conn} ->
        ExStatsD.increment("icepick.inbound-requests.counter")
        send_resp(conn, 204, "")
      {:error, :timeout} ->
        ExStatsD.increment("icepick.inbound-requests-timeout.counter")
    end
    #req = Poison.Parser.parse!(body)
    #IO.puts inspect(req)

  end

  def start_link() do 
    {:ok, _} = Plug.Adapters.Cowboy.http(
      __MODULE__,
      [acceptors: 1000],
      port: 8000)
  end

end