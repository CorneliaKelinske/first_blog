defmodule FirstBlog.Email.Contact do
  @moduledoc """
  Contact form email to be sent to admin
  """

  alias FirstBlog.Email.Content
  import Ecto.Changeset

  @doc "Ensure that data is valid before sending"
  def changeset(attrs) do
    {%Content{}, Content.types()}
    |> cast(attrs, [:from_email, :name, :subject, :message])
    |> validate_required([:from_email, :name, :subject, :message])
    |> validate_length(:message, min: 10, max: 1000)
    
  end
end
