defmodule Icepick.Mixfile do
  use Mix.Project

  def project do
    [app: :icepick,
     version: "0.1.0",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"},
     {:poison, "~> 1.5"},
     {:ex_statsd, ">= 0.5.1"}
    ]
  end
end
