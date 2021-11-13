defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder
  alias FirstBlog.Email.Captcha, as: EmailCaptcha

  action_fallback FirstBlogWeb.FallbackController
  require Logger

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    with {:ok, captcha_text, captcha_image} <- EmailCaptcha.view() do
      Logger.debug("This is the captcha image created on new #{inspect(__MODULE__)}: #{inspect(captcha_image)}")
      IO.inspect(captcha_image, label: "captcha image created on new")
      render(conn, "new.html",
        page_title: "Contact",
        changeset: Contact.changeset(%{}),
        captcha_text: captcha_text,
        captcha_image: captcha_image
      )
    end
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
        with {:ok, captcha_text, captcha_image} <- EmailCaptcha.view() do
          Logger.debug("This is the captcha image I see on create if changeset validation failed #{inspect(__MODULE__)}: #{inspect(captcha_image)}")
          IO.inspect(captcha_image, label: "captcha image created on refresh after failed changeset validation")
          conn
          |> put_flash(:error, "There was a problem sending your message")
          |> render("new.html",
            changeset: changeset,
            captcha_text: captcha_text,
            captcha_image: captcha_image
          )
        end

      _ ->
        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  def create(conn, %{"content" => message_params}) do
    changeset = Contact.changeset(message_params)

    with {:ok, captcha_text, captcha_image} <- EmailCaptcha.view() do
      Logger.debug("This is the captcha image I see on create if captcha answer was incorrect #{inspect(__MODULE__)}: #{inspect(captcha_image)}")
      IO.inspect(captcha_image, label: "captcha image received with invalid captcha answer")
      conn
      |> put_flash(:error, "Your answer did not match the letters below. Please try again!")
      |> render("new.html",
        changeset: changeset,
        captcha_text: captcha_text,
        captcha_image: captcha_image
      )
    end
  end
end
