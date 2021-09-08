defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.Contact
  alias FirstBlog.Mailer
  alias FirstBlog.EmailBuilder

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", page_title: "Contact", changeset: new_changeset())
  end



  @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  def create(conn, %{"content" => message_params}) do

    changeset = Contact.changeset(message_params)

    with{:ok, content} <- Ecto.Changeset.apply_action(changeset, :insert),
        %Swoosh.Email{} = message <- EmailBuilder.create_email(content),
        {:ok, %{id: _id}} <- Mailer.deliver(message) do
      conn
      |> put_flash(:info, "Your message has been sent successfully")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      # Failed changeset validation
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "There was a problem sending your message")
        |> render("new.html", changeset: changeset)

      # Other error
      _error ->
        conn
        |> put_flash(:error, "Ouuups")
        |> redirect(to: Routes.contact_path(conn, :new))
    end
  end

  defp new_changeset, do: Contact.changeset(%{})
end
