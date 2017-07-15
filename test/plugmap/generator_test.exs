Code.require_file "../../test_helper.exs", __ENV__.file

defmodule Plugmap.GeneratorTest do
  use ExUnit.Case
  doctest Plugmap.Generator

  test "create root" do
    Plugmap.Generator.create_root()
  end

  test "create element" do
    Plugmap.Generator.create_element("https://test.com", changefreq: "daily", priority: 1.0)
  end

  test "create sitemap" do
    root = Plugmap.Generator.create_root()
    [
      Plugmap.Generator.create_element("https://test.com"),
      Plugmap.Generator.create_element("https://test.com", changefreq: "daily"),
      Plugmap.Generator.create_element("https://test.com", changefreq: "daily", priority: 1.0),
      Plugmap.Generator.create_element("https://test.com", changefreq: "daily", priority: 1.0, lastmod: "2005-01-01")
    ]
      |> Plugmap.Generator.add_to_element(root)
      |> Plugmap.Generator.generate_sitemap
  end
end
