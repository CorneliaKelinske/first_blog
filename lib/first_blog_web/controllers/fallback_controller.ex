defmodule FirstBlogWeb.FallbackController do
  use FirstBlogWeb, :controller

  def call(conn, nil) do
    conn
    |> put_flash(:error, "Something went wrong")
    |> redirect(to: Routes.contact_path(conn, :new))
  end
end
