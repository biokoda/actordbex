defmodule ActorDB.Mixfile do
  use Mix.Project

  def project do
    [app: :actordbex,
     version: "0.9.0",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :actordb_client]]
  end

  defp deps do
    [
      {:actordb_client, git: "https://github.com/biokoda/actordb_client", branch: "master"}
    ]
  end
end
