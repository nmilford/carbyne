defmodule Carbyne.Mixfile do
  use Mix.Project

  def project do
    [ app: :carbyne,
      version: "0.0.1",
      elixir: "~> 0.10.2-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:socket] ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [{ :socket, "0.1.2", [github: "meh/elixir-socket", tag: "v0.1.2"]}]
  end
end
