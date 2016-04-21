defmodule Icepick do
  use Application

  def main(_args) do
    Icepick.start(nil, nil)
    :timer.sleep(:infinity)
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Icepick.PlugRouter, [])
    ]

    opts = [strategy: :one_for_one, name: Icepick2.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
