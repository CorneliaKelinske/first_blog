defmodule FirstBlogWeb.PageController do
  use FirstBlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def about_me(conn, _params) do
    render(conn, "about_me.html")
  end
end
