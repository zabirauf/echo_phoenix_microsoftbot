defmodule EchoBot.Mixfile do
  use Mix.Project

  def project do
    [app: :echo_bot,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {EchoBot, []},
     applications: [:phoenix, :cowboy, :logger, :gettext, :ex_microsoftbot]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.1.4"},
     {:gettext, "~> 0.9"},
     {:cowboy, "~> 1.0"},
     {:ex_microsoftbot, github: "zabirauf/ex_microsoftbot"},
     {:phoenix_microsoftbot, github: "zabirauf/phoenix_microsoftbot"}]
  end
end
