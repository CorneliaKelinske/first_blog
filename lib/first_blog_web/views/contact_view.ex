defmodule FirstBlogWeb.ContactView do
  use FirstBlogWeb, :view

  @spec production? :: boolean
  def production? do
    Application.get_env(:first_blog, :env) == :prod
  end
end
