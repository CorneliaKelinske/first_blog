defmodule FirstBlogWeb.PostView do
  use FirstBlogWeb, :view

  alias FirstBlogWeb.Paginate

  defdelegate paginate(conn, page), to: Paginate, as: :build
end
