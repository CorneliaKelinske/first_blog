defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder
  alias FirstBlog.Email.SecretAnswer

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    with {captcha_text, captcha_image} <- RustCaptcha.generate() do
      id = SecretAnswer.check_in(captcha_text)

      render(conn, "new.html",
        page_title: "Contact",
        changeset: Contact.changeset(%{}),
        id: id,
        captcha_image: captcha_image
      )
    end

    # Make a fallback controller to handle nil returning from this action
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => %{"not_a_robot" => text, "form_id" => form_id} = message_params}) do
    changeset = Contact.changeset(message_params)

    with :ok <- SecretAnswer.check_out({text, form_id}),
         {:ok, content} <- Ecto.Changeset.apply_action(changeset, :insert),
         %Swoosh.Email{} = message <- EmailBuilder.create_email(content),
         {:ok, _map} <- Mailer.deliver(message) do
      conn
      |> put_flash(:success, "Your message has been sent successfully")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      # Captcha text was entered incorrectly
      {:error, :wrong_captcha} ->
        render_page(
          conn,
          changeset,
          :error,
          "Your answer did not match the captcha. Please try again!"
        )

      # Failed changeset validation
      {:error, %Ecto.Changeset{} = changeset} ->
        render_page(
          conn,
          changeset,
          :error,
          "There was a problem sending your message"
        )

      # Anything else
      _ ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  defp render_page(conn, changeset, message_type, message) do
    with {captcha_text, captcha_image} <- RustCaptcha.generate() do
      id = SecretAnswer.check_in(captcha_text)

      conn
      |> put_flash(message_type, message)
      |> render("new.html",
        changeset: changeset,
        id: id,
        captcha_image: captcha_image
      )
    end
  end
end
