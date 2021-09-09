defmodule FirstBlog.Mailer do
  @moduledoc """
  Module implementing the Swoosh Mailer functionality
  """
  use Swoosh.Mailer, otp_app: :first_blog
end
