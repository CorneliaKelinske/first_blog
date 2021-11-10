defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    with {:ok, captcha_text, captcha_image} <- Captcha.get() do
      render(conn, "new.html",
        page_title: "Contact",
        changeset: Contact.changeset(%{}),
        captcha_text: captcha_text,
        captcha_image: captcha_image
      )
    else
      {:timeout} ->
        conn
        |> put_flash(:error, "Could not generate captcha")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => message_params}) do
    if message_params["not_a_robot"] === message_params["answer"] do
      changeset = Contact.changeset(message_params)
      IO.inspect(message_params)

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
          |> render("new.html",
            changeset: changeset,
            captcha_text: Map.fetch!(message_params, "not_a_robot"),
            captcha_image: Map.fetch!(message_params, "image")
          )

        # Other error
        _ ->
          conn
          |> put_flash(:error, "Something did not work. Please try again!")
          |> redirect(to: Routes.contact_path(conn, :new))
      end
    else
      conn
      |> put_flash(:error, "Your answer did not match the letters below. Please try again!")
      |> redirect(to: Routes.contact_path(conn, :new))
    end
  end
end
