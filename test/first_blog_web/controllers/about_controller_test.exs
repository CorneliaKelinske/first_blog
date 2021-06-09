defmodule FirstBlogWeb.PageControllerTest do
  use FirstBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/about")
    assert html_response(conn, 200) =~ "All About ME!"
  end
end
