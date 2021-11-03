defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", page_title: "Contact", changeset: Contact.changeset(%{}))
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => message_params} = params) do
    changeset = Contact.changeset(message_params)

    with {:ok, _response} <- Recaptcha.verify(params["g-recaptcha-response"]),
         {:ok, content} <- Ecto.Changeset.apply_action(changeset, :insert),
         %Swoosh.Email{} = message <- EmailBuilder.create_email(content),
         {:ok, _map} <- Mailer.deliver(message) do
      conn
      |> put_flash(:success, "Your message has been sent successfully")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      # Failed changeset validation
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> render("new.html", changeset: changeset)

      # Other error
      # Failed recaptcha
      _ ->
        conn
        |> put_flash(:error, "Something went wrong with the recaptcha")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end
end
