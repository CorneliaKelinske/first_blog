defmodule FirstBlog.EmailBuilder do
  import Swoosh.Email
  alias FirstBlog.Contact

  def create_email(%{from_email: from_email, name: name, subject: subject, message: message}) do
    new()
    |> to({"Cornelia", "cornelia@example.com"})
    |> from({name, from_email})
    |> subject(subject)
    |> html_body("<h1>#{message}</h1>")
    |> text_body("#{message}\n")
  end
end
