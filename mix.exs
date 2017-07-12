defmodule Plugmap.Mixfile do
  use Mix.Project

  def project do
    [app: :plugmap,
     version: "0.1.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     description: description(),
     deps: deps(),
    
     # Docs
     name: "Plugmap",
     source_url: "https://github.com/nerdslabs/plugmap",
     homepage_url: "https://github.com/nerdslabs/plugmap",
     docs: [main: "Plugmap", # The main page in the docs
      # logo: "path/to/logo.png",
      extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false},
     {:xml_builder, "~> 0.1.1"},
     {:inch_ex, "~> 0.5", only: [:dev, :test]}]
  end

  defp description do
    """
    Sitemap XML generator
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :plugmap,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Krystian Drożdżyński"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nerdslabs/plugmap"}
    ]
  end
end
