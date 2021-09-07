defmodule FirstBlog.MailerTest do
  use FirstBlog.DataCase
  alias FirstBlog.{Mailer, EmailBuilder}
import Swoosh.TestAssertions

  #@valid_data %{from_email => "some_email", name => "rando", subject => "random", message => "blablab"}

  test "deliver/1 delivers an email from a user to a mailbox" do
    response = %{from_email: "hugo@example.com", name: "Hugo", subject: "test", message: "I am testing this thing"}
    |> EmailBuilder.create_email()
    |> Mailer.deliver()

    assert {:ok, %{}} = response
    assert_email_sent()
  end

end
