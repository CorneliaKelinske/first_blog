defmodule FirstBlog.Email.Content do
  @moduledoc "The content for an email message"
  defstruct from_email: nil, to_email: nil, name: nil, subject: nil, message: nil

  @type t :: %__MODULE__{
          from_email: String.t(),
          to_email: String.t(),
          name: String.t(),
          subject: String.t(),
          message: String.t()
        }

  @spec types :: %{
          from_email: :string,
          message: :string,
          name: :string,
          to_email: :string,
          subject: :string
        }
  def types do
    %{from_email: :string, to_email: :string, name: :string, subject: :string, message: :string}
  end
end
