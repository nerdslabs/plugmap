defmodule Plugmap.TestRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  use Plugmap

  defsitemap :pages_static_1 do
    page "https://website.com", changefreq: "daily", priority: 1.0
  end

  defsitemap :pages_static_2 do
    static do
      page "https://website.com", changefreq: "daily", priority: 1.0
      page "https://website.com/test", changefreq: "daily", priority: 0.8
    end
  end

  defsitemap :pages_dynamic do
    dynamic do
      Enum.reduce(1..10, [], fn(x, acc) ->
          item = page "https://website.com", changefreq: "daily", priority: x/10
          [item | acc]
        end)
    end
  end

  get "/pages_static_1" do
    pages_static_1(conn)
  end

  get "/pages_static_2" do
    pages_static_2(conn)
  end

  get "/pages_dynamic" do
    pages_dynamic(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end