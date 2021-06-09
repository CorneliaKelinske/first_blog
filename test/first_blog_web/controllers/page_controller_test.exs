defmodule FirstBlogWeb.PageControllerTest do
  use FirstBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to The Bro-Grammer!"
  end
end
