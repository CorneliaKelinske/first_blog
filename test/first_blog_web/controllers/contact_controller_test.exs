defmodule FirstBlogWeb.ContactControllerTest do
  use FirstBlogWeb.ConnCase

  test "contact", %{conn: conn} do
    conn = get(conn, "/contact")
    assert html_response(conn, 200) =~ "Contact me"
  end

  describe "create" do
    test "delivers email and redirects to index when form is filled in correctly, "
  end

end
