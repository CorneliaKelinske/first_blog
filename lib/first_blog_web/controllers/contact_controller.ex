defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", page_title: "Contact", changeset: Contact.changeset(%{}), captcha_image: captcha_image())
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => message_params}) do
    changeset = Contact.changeset(message_params)

    with {:ok, content} <- Ecto.Changeset.apply_action(changeset, :insert),
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
        |> put_flash(:error, "ouuupsies")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  defp captcha_image() do
    case Captcha.get() do
      {:ok, _text, img_binary } -> img_binary
        # save text in session, then send img to client
      {:timeout} -> "Timeout"
        # log some error
    end
  end
end
