defmodule FirstBlogWeb.FallbackController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact

  def call(conn, :no_captcha) do
    render(conn, "new.html",
      page_title: "Contact",
      changeset: Contact.changeset(%{}),
      captcha_text: "Failed to create captcha. Please refresh the page!",
      captcha_image: nil
    )
  end
end
