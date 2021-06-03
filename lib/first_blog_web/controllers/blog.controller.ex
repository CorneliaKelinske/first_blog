defmodule FirstBlogWeb.BlogController do
  use FirstBlogWeb, :controller

  def blog(conn, _oarams) do
    render(conn, "blog.html")
  end
end
