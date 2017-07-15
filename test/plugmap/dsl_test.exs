Code.require_file "../../test_helper.exs", __ENV__.file

Code.require_file "../test_router.exs", __ENV__.file

defmodule Plugmap.DSLTest do
    use ExUnit.Case
    doctest Plugmap.DSL

    use Plugmap
    use Plug.Test

    @opts Plugmap.TestRouter.init([])

    test "static sitemap 1" do
        # Create a test connection
        conn = conn(:get, "/pages_static_1")

        # Invoke the plug
        conn = Plugmap.TestRouter.call(conn, @opts)

        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 200
        # assert conn.resp_body == "world"
    end

    test "static sitemap 2" do
        # Create a test connection
        conn = conn(:get, "/pages_static_2")

        # Invoke the plug
        conn = Plugmap.TestRouter.call(conn, @opts)

        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 200
        # assert conn.resp_body == "world"
    end

    test "dynamic sitemap" do
        # Create a test connection
        conn = conn(:get, "/pages_dynamic")

        # Invoke the plug
        conn = Plugmap.TestRouter.call(conn, @opts)

        # Assert the response and status
        assert conn.state == :sent
        assert conn.status == 200
        # assert conn.resp_body == "world"
    end

end