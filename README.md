[![Inline docs](http://inch-ci.org/github/nerdslabs/plugmap.svg)](http://inch-ci.org/github/nerdslabs/plugmap)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/nerdslabs/plugmap.svg)](https://beta.hexfaktor.org/github/nerdslabs/plugmap)
[![travis-ci.org](https://travis-ci.org/nerdslabs/plugmap.svg?branch=master)](https://travis-ci.org/nerdslabs/plugmap)

# Plugmap

**Plugmap is sitemap generation library for Plug/Phoenix Framework**

## Installation

Add `plugmap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:plugmap, "~> 0.1.0"}]
end
```

## Usage

### Plug
```elixir
defmodule Sitemaps do
  use Plugmap
  import Plug.Conn

  defsitemap :pages do
    page "https://website.com", changefreq: "daily", priority: 1.0
    page "https://website.com/page", changefreq: "monthly", priority: 0.5
  end
end
```

### Phoenix Framework
#### Controller
```elixir
defmodule SomeApp.SitemapsController do
  use SomeApp.Web, :controller
  use Plugmap

  defsitemap :pages do
    page "https://website.com", changefreq: "daily", priority: 1.0
    page "https://website.com/page", changefreq: "monthly", priority: 0.5
  end
end
```
#### Router
```elixir
get "/sitemap", SitemapsController, :pages
```