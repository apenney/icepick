defmodule JsonEngine do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def parse(eng, data) do
    GenServer.call(eng, {:parse, data})
  end

  def close(eng) do
    GenServer.call(eng, :close)
  end

  # Callbacks

  def init() do
    {:ok, nil}
  end

  def handle_call({:parse, data}, from, _) do
    ExStatsD.increment("icepick.inbound-requests.parsed.counter")
    Task.async(fn ->
      json = ExStatsD.timing "icepick.inbound-requests.parsing.timer", fn ->
        Poison.Parser.parse!(body)
      end
      GenServer.reply(from, json)
    end)
    {:noreply, nil}
  end

  def handle_call(:close, _, _) do
    {:stop, :normal, nil}
  end

end