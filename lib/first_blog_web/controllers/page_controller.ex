defmodule FirstBlogWeb.PageController do
  use FirstBlogWeb, :controller

  def index(conn, _params) do
    assigns = [
      page_title: "Welcome"
    ]

    render(conn, "index.html", assigns)
  end

  def about_me(conn, _params) do
    assigns = [
      page_title: "About me"
    ]

    render(conn, "about_me.html", assigns)
  end
end
