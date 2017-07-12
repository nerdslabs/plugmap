defmodule Plugmap.Generator do
    @moduledoc false
    
    @default_sitemap_attrs %{"xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance",
            "xsi:schemaLocation": "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd",
            "xmlns": "http://www.sitemaps.org/schemas/sitemap/0.9"}

    import XmlBuilder

    def create_root() do
        element(:urlset, @default_sitemap_attrs, [])
    end
    
    def create_element(loc, attrs \\ []) do
        result = element(:url, %{}, [
            element(:loc, loc |> URI.encode)
        ])

        result = add_attr(:changefreq, attrs, result)
        result = add_attr(:priority, attrs, result)
        result = add_attr(:lastmod, attrs, result)

        result
    end

    def add_attr(attr, attrs, target) do
        case attrs[attr] do
            nil -> target
            value -> add_to_element(element(attr, value), target)
        end
    end

    def add_to_element(new, element) when is_tuple(new) do
        [new | []] |> add_to_element(element)
    end

    def add_to_element(new, element) when is_list(new) do
        combine = elem(element, 2) ++ new

        element
        |> Tuple.delete_at(2)
        |> Tuple.append(combine)
    end

    def generate_sitemap(root) do
        root |> doc
    end
end