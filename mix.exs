defmodule Icepick.Mixfile do
  use Mix.Project

  def project do
    [app: :icepick,
     version: "0.1.0",
     elixir: "~> 1.2.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
      escript: [main_module: Icepick],
     deps: deps]
  end

  def application do
    [
      applications: [
        :logger, :cowboy, :plug, :ex_statsd
      ],
      mod: {Icepick, []}
    ]
  end

  defp deps do
    [
     {:cowboy, "~> 1.0.4"},
     {:plug, "~> 1.1.4"},
     {:poison, "~> 2.1.0"},
     {:ex_statsd, "~> 0.5.2"}
    ]
  end
end
