defmodule FirstBlog.Email.Contact do
  @moduledoc """
  Contact form email to be sent to admin
  """
  import Bamboo.Email
  alias FirstBlog.Email.Content
  import Ecto.Changeset

  @site "brogrammer.connie.codes"

  @doc "Build a new Bamboo struct"
  @spec compose(FirstBlog.Email.Content.t()) :: Bamboo.Email.t()
  def compose(%Content{from_email: from_email, name: name} = content) do
    new_email(
      to: ["corneliakelinske@gmail.com"],
      from: from_email,
      subject: "[#{@site}] Message from #{name}",
      html_body: contact_html_body(content),
      text_body: contact_text_body(content)
    )
  end

  @doc "Ensure that data is valid before sending"
  @spec changeset(struct(), map()) :: %Ecto.Changeset{}
  def changeset(content, attrs) do
    {content, Content.types()}
    |> cast(attrs, [:from_email, :name, :message])
    |> validate_required([:from_email, :name, :message])
    |> validate_length(:message, min: 10, max: 1000)
  end

  @spec contact_html_body(FirstBlog.Email.Content.t()) :: String.t()
  defp contact_html_body(%Content{
         from_email: from_email,
         name: name,
         message: message
       }) do
    """
      <p>You have received a new message from #{@site}</p>
      <p>
      <strong>Name:</strong> #{name} <br>
      <strong>Email:</strong> #{from_email} <br>
      <strong>Message:</strong> <br>
      #{message}
      </p>
    """
  end

  @spec contact_text_body(FirstBlog.Email.Content.t()) :: String.t()
  defp contact_text_body(%Content{
         from_email: from_email,
         name: name,
         message: message
       }) do
    """
      You have received a new message from #{@site}
      Name: #{name}
      Email: #{from_email}
      Message:
      #{message}
    """
  end
end
