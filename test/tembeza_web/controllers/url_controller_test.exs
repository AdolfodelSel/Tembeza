defmodule TembezaWeb.UrlControllerTest do
  use TembezaWeb.ConnCase

  alias TembezaWeb.UrlController

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "fetch urls" do

    test "success fetch", %{conn: conn, bypass: bypass}do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          "<!doctype html><html><body><a href='http://github.com/philss/floki'>Github page</a><img src='img_girl.jpg' alt='Girl in a jacket' width='500' height='600'></body></html>"
        )
      end)

      response =
        UrlController.fetch(conn, %{"url" => "http://localhost:#{bypass.port}/"})
        |> response(200)
        |> Poison.decode!()
      expected = %{"result" => %{"assets" => ["img_girl.jpg"], "links" => ["http://github.com/philss/floki"]}, "status" => true}

      assert response == expected
    end

    test "empty response", %{conn: conn, bypass: bypass}do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          "<!doctype html><html><body></body></html>"
        )
      end)

      response =
        UrlController.fetch(conn, %{"url" => "http://localhost:#{bypass.port}/"})
        |> response(200)
        |> Poison.decode!()
      expected = %{"result" => %{"assets" => [], "links" => []}, "status" => true}

      assert response == expected
    end

    test "not found", %{conn: conn, bypass: bypass} do
      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(
          conn,
          404,
          ""
        )
      end)

      response =
        UrlController.fetch(conn, %{"url" => "http://localhost:#{bypass.port}/"})
        |> response(200)
        |> Poison.decode!()
      expected = %{"error" => "Error fetching the url", "status" => false}

      assert response == expected
    end

  end
end
