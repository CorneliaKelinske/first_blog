defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    {captcha_text, captcha_image} = RustCaptcha.generate()

    render(conn, "new.html",
      page_title: "Contact",
      changeset: Contact.changeset(%{}),
      captcha_text: captcha_text,
      captcha_image: captcha_image
    )
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => %{"not_a_robot" => txt, "answer" => txt} = message_params}) do
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
        {captcha_text, captcha_image} = RustCaptcha.generate()

        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> render("new.html",
          changeset: changeset,
          captcha_text: captcha_text,
          captcha_image: captcha_image
        )

      _ ->
        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  def create(conn, %{"content" => message_params}) do
    changeset = Contact.changeset(message_params)
    {captcha_text, captcha_image} = RustCaptcha.generate()

    conn
    |> put_flash(:error, "Your answer did not match the letters below. Please try again!")
    |> render("new.html",
      changeset: changeset,
      captcha_text: captcha_text,
      captcha_image: captcha_image
    )
  end
end
