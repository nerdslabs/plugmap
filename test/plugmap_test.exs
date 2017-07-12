defmodule PlugmapTest do
  use ExUnit.Case
  doctest Plugmap.DSL

  test "create root" do
    Plugmap.Generator.create_root()
  end

  test "create element" do
    Plugmap.DSL.page("https://test.com", changefreq: "daily", priority: 1.0)
  end

  test "create sitemap" do
    root = Plugmap.Generator.create_root()
    [
      Plugmap.DSL.page("https://test.com"),
      Plugmap.DSL.page("https://test.com", changefreq: "daily"),
      Plugmap.DSL.page("https://test.com", changefreq: "daily", priority: 1.0),
      Plugmap.DSL.page("https://test.com", changefreq: "daily", priority: 1.0, lastmod: "2005-01-01")
    ]
      |> Plugmap.Generator.add_to_element(root)
      |> Plugmap.Generator.generate_sitemap |> IO.inspect
  end
end
