defmodule FirstBlog.Email do
  @moduledoc "Handles sending email"
  alias FirstBlog.Email.{Contact, Content}
  use Bamboo.Mailer, otp_app: :first_blog

  @spec contact_message(map) :: {:error, Ecto.Changeset.t()} | {:ok, Bamboo.Email.t()}
  def contact_message(attrs) do
    changeset = Contact.changeset(%Content{}, attrs)

    case changeset do
      %{valid?: true, changes: changes} ->
        message =
          %Content{}
          |> Map.merge(changes)
          |> Contact.compose()

        {:ok, message}

      _ ->
        {:error, changeset}
    end
  end

  @spec send(Bamboo.Email.t()) :: {:ok, Bamboo.Email.t()} | {:error, binary | map}
  def send(message) do
    deliver_now(message)
  end
end
