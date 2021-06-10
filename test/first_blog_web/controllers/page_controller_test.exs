defmodule FirstBlogWeb.PageControllerTest do
  use FirstBlogWeb.ConnCase

  test "index", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to The Bro-Grammer!"
  end

  test "about", %{conn: conn} do
    conn = get(conn, "/about")
    assert html_response(conn, 200) =~ "All About ME!"
  end

  test "blog", %{conn: conn} do
    conn = get(conn, "/blog")
    assert html_response(conn, 200) =~ "And this is the home of all the blog posts"
  end
end
