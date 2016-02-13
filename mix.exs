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

  defp description do
    """
    ActorDB client for Elixir
    """
  end

  defp package do
    [
     files: ["config", "lib", "test", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Denis Justinek", "Sergej Jurecko"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/biokoda/actordbex",
              "Docs" => "https://github.com/biokoda/actordbex/blob/master/README.md"}]
  end
end
