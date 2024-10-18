defmodule Plugmap.DSLTest do
  use ExUnit.Case
  doctest Plugmap.DSL

  use Plugmap
  use Plug.Test

  @opts Plugmap.TestRouter.init([])

  test "static sitemap 1" do
    conn = conn(:get, "/pages_static_1")

    conn = Plugmap.TestRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert conn.resp_body ==
             "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>1.0</priority>\n  </url>\n</urlset>"
  end

  test "static sitemap 2" do
    conn = conn(:get, "/pages_static_2")

    conn = Plugmap.TestRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert conn.resp_body ==
             "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\n  <url>\n    <loc>https://website.com/test</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.8</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>1.0</priority>\n  </url>\n</urlset>"
  end

  test "dynamic sitemap" do
    conn = conn(:get, "/pages_dynamic")

    conn = Plugmap.TestRouter.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200

    assert conn.resp_body ==
             "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd\">\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.1</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.2</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.3</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.4</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.5</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.6</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.7</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.8</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>0.9</priority>\n  </url>\n  <url>\n    <loc>https://website.com</loc>\n    <changefreq>daily</changefreq>\n    <priority>1.0</priority>\n  </url>\n</urlset>"
  end
end
