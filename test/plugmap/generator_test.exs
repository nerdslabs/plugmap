defmodule Plugmap.GeneratorTest do
  use ExUnit.Case
  doctest Plugmap.Generator

  test "create root" do
    assert {:urlset,
            %{
              xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9",
              "xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
              "xsi:schemaLocation":
                "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
            }, []} = Plugmap.Generator.create_root()
  end

  test "create element" do
    assert {:url, %{},
            [
              {:loc, nil, "https://test.com"},
              {:changefreq, nil, "daily"},
              {:priority, nil, 1.0}
            ]} =
             Plugmap.Generator.create_element("https://test.com",
               changefreq: "daily",
               priority: 1.0
             )
  end

  test "create sitemap" do
    root = Plugmap.Generator.create_root()

    sitemap =
      [
        Plugmap.Generator.create_element("https://test.com"),
        Plugmap.Generator.create_element("https://test.com", changefreq: "daily"),
        Plugmap.Generator.create_element("https://test.com", changefreq: "daily", priority: 1.0),
        Plugmap.Generator.create_element("https://test.com",
          changefreq: "daily",
          priority: 1.0,
          lastmod: "2005-01-01"
        )
      ]
      |> Plugmap.Generator.add_to_element(root)
      |> Plugmap.Generator.generate_sitemap()

    assert sitemap ==
             "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\n  <url>\n    <loc>https://test.com</loc>\n  </url>\n  <url>\n    <loc>https://test.com</loc>\n    <changefreq>daily</changefreq>\n  </url>\n  <url>\n    <loc>https://test.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>1.0</priority>\n  </url>\n  <url>\n    <loc>https://test.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>1.0</priority>\n    <lastmod>2005-01-01</lastmod>\n  </url>\n</urlset>"
  end
end
