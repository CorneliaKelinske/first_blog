defmodule FirstBlogWeb.ContactController do
  use FirstBlogWeb, :controller
  alias FirstBlog.Email.{Contact, Content}

  @spec new(Plug.Conn.t(), map) :: Plug.Conn.t()
  def new(conn, _params) do
    render(conn, "new.html", page_title: "Contact", changeset: new_changeset())
  end

  def create(_conn, params) do
    params
  end

  # @spec create(Plug.Conn.t(), map) :: Plug.Conn.t()
  # def create(conn, %{"message" => message_params} = params) do
  #   with {:ok, _response} <- verify(params),
  #        {:ok, message} <- Email.contact_message(message_params) do
  #     Email.send(message)

  #     conn
  #     |> put_flash(:success, "Your message has been sent successfully")
  #     |> redirect(to: Routes.page_path(conn, :index))
  #   else
  #     # Failed changeset validation
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       conn
  #       |> put_flash(:error, "There was a problem sending your message")
  #       |> render("new.html", changeset: changeset)

  #     # Failed recaptcha
  #     _ ->
  #       conn
  #       |> put_flash(:error, "Something went wrong with the recaptcha")
  #       |> redirect(to: Routes.contact_path(conn, :new))
  #   end
  # end

  defp new_changeset, do: Contact.changeset(%Content{}, %{})

  # defp verify(params) do
  #   case Application.get_env(:alan_vardy, :env) do
  #     :systemtest -> {:ok, "We have to mock for system tests"}
  #     _# -> Recaptcha.verify(params["g-recaptcha-response"])
  #     _ -> "ERROR"
  #   end
  # end
end
