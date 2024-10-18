[![Hex.pm Downloads](https://img.shields.io/hexpm/dt/plugmap)](https://hex.pm/packages/plugmap)
[![Inline docs](http://inch-ci.org/github/nerdslabs/plugmap.svg)](http://inch-ci.org/github/nerdslabs/plugmap)

# Plugmap

**Plugmap is sitemap generation library for Plug/Phoenix Framework**

## Installation

Add `plugmap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:plugmap, "~> 0.3.0"}]
end
```

## Usage

### Plug
```elixir
defmodule Sitemaps do
  use Plugmap
  import Plug.Conn

  defsitemap :pages do
    static do
      page "https://website.com", changefreq: "daily", priority: 1.0
      page "https://website.com/page", changefreq: "monthly", priority: 0.5
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
end
```
Then you can call method ```Sitemaps.pages(conn)``` in ```Plug``` ```call``` function or in ```Plug.Router```

### Phoenix Framework
#### Controller
```elixir
defmodule SomeApp.SitemapsController do
  use SomeApp.Web, :controller
  use Plugmap

  defsitemap :pages do
    static do
      page "https://website.com", changefreq: "daily", priority: 1.0
      page "https://website.com/page", changefreq: "monthly", priority: 0.5
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

end
```
#### Router
```elixir
get "/sitemap/pages", SitemapsController, :pages
get "/sitemap/items", SitemapsController, :pages_dynamic
```

More info in [documentation](https://hexdocs.pm/plugmap/Plugmap.DSL.html)

## Routemap

- [ ] Cache sitemaps
- [ ] Add news sitemap