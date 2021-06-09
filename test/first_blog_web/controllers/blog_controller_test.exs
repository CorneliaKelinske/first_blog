defmodule FirstBlogWeb.PageControllerTest do
  use FirstBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/blog")
    assert html_response(conn, 200) =~ "And this is the home of all the blog posts"
  end
end
