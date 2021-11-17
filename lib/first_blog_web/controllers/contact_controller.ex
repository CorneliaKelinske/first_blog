defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder
  alias FirstBlog.Email.SecretAnswer

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    {captcha_text, captcha_image} = RustCaptcha.generate()
    {:ok, id} = SecretAnswer.check_in(captcha_text)


    render(conn, "new.html",
      page_title: "Contact",
      changeset: Contact.changeset(%{}),
      id: id,
      captcha_image: captcha_image
    )
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => %{"not_a_robot" => text, "form_id" => form_id} = message_params}) do
    changeset = Contact.changeset(message_params)
    IO.inspect(form_id, label: "form_id")

    case SecretAnswer.check_out({text, form_id}) do
      :ok ->
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
            {:ok, id} = SecretAnswer.check_in(captcha_text)

            conn
            |> put_flash(:error, "There was a problem sending your message")
            |> render("new.html",
              changeset: changeset,
              id: id,
              captcha_image: captcha_image
            )
        end

      {:error, :wrong_captcha} ->
        {captcha_text, captcha_image} = RustCaptcha.generate()
        {:ok, id} = SecretAnswer.check_in(captcha_text)

        conn
        |> put_flash(:error, "Your answer did not match the letters below. Please try again!")
        |> render("new.html",
          page_title: "Contact",
          changeset: changeset,
          id: id,
          captcha_image: captcha_image
        )
      _ ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end
end
