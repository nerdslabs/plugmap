defmodule Plugmap.Mixfile do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :plugmap,
      version: @version,
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      deps: deps(),

      # Docs
      name: "Plugmap",
      source_url: "https://github.com/nerdslabs/plugmap",
      homepage_url: "https://github.com/nerdslabs/plugmap",
      # The main page in the docs
      docs: [
        source_ref: "v#{@version}",
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/plugmap", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.34.2", only: :dev, runtime: false},
      {:xml_builder, "~> 2.3.0"},
      {:inch_ex, "~> 2.0.0", only: [:dev, :test]},
      {:plug, "~> 1.16.1", only: :test}
    ]
  end

  defp description do
    """
    Sitemap XML generator
    """
  end

  defp package do
    [
      name: :plugmap,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Krystian Drożdżyński"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nerdslabs/plugmap"}
    ]
  end
end
