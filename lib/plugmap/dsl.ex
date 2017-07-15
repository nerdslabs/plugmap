defmodule Plugmap.DSL do
    @moduledoc """
    This is the DSL sitemap module.
    """

    alias Plugmap.Generator
    
    @doc false
    defmacro __using__(_opts) do
        quote do
            import Plugmap.DSL
        end
    end

    @doc """
    Create function which generate sitemap xml.

    Returns `Plug.Conn` with sitemap and `text/xml` content type.

    ## Example static pages

        defsitemap :pages do
            static do
                page "https://test.com", changefreq: "monthly", priority: 0.7
                page "https://test.com/list", changefreq: "daily", priority: 1.0
            end
        end

    ## Example dynamic pages

        defsitemap :pages_dynamic do
            dynamic do
                Enum.reduce(1..10, [], fn(x, acc) ->
                    item = page "https://website.com", changefreq: "daily", priority: x/10
                    [item | acc]
                    end)
            end
        end
    
    It must return ```list``` of items generated with ```page``` function

    """
    defmacro defsitemap(name, contents) do
        items = case contents do
            [do: {:static, _, [[do: {:__block__, _, items}]]}] -> items
            [do: {:static, _, [[do: item]]}] -> [item | []]
            [do: {:dynamic, _, [[do: items]]}] -> items
            [do: {:__block__, _, items}] -> items
            [do: item] -> [item | []]
        end
        quote do
            def unquote(name)(conn, _ \\ %{}) do
                xml = Generator.create_root
                sitemap = Enum.reduce(unquote(items), [],
                    fn(x, acc) ->
                        item = x 
                        [item | acc]
                    end)
                    |> Generator.add_to_element(xml)
                    |> Generator.generate_sitemap
                conn
                    |> put_resp_content_type("text/xml")
                    |> send_resp(200, sitemap)
            end
        end
    end

    @doc """
    Add page to sitemap.

    ## Examples

        page "https://test.com"

    """
    defdelegate page(loc), to: Generator, as: :create_element

    @doc """
    Add page with attributes to sitemap.

    ## Examples

        page "https://test.com", changefreq: "monthly", priority: 0.7

    """
    defdelegate page(loc, attrs), to: Generator, as: :create_element

end