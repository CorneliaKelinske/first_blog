defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.{Contact, Content}
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", page_title: "Contact", changeset: new_changeset())
  end



  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => message_params} = params) do
    IO.inspect(message_params)
    with {:ok, message} <- EmailBuilder.create_email(message_params),
         {:ok, %{}} <- Mailer.deliver(message) do
      conn
      |> put_flash(:success, "Your message has been sent successfully")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      # Failed changeset validation
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> render("new.html", changeset: changeset)

      # Failed recaptcha
      _ ->
        conn
        |> put_flash(:error, "Something went wrong with the recaptcha")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  defp new_changeset, do: Contact.changeset(%Content{}, %{})
end
