defmodule FirstBlogWeb.ContactControllerTest do
  use FirstBlogWeb.ConnCase

  @valid_params %{
    from_email: "tester@test.com",
    name: "testy McTestface",
    subject: "Testing, testing",
    message: "Hello, this is a test"
  }

  @invalid_params %{
    from_email: "tester@test.com",
    name: nil,
    subject: "Testing, testing"
  }

  test "new renders form", %{conn: conn} do
    conn = get(conn, Routes.contact_path(conn, :new))
    assert html_response(conn, 200) =~ "Contact me"
  end

  describe "create" do
    test "delivers email and redirects to index when when valid params are provided", %{
      conn: conn
    } do
      conn = post(conn, Routes.contact_path(conn, :create), content: @valid_params)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "renders errors when params provided are invalid", %{conn: conn} do
      conn = post(conn, Routes.contact_path(conn, :create), content: @invalid_params)
      assert html_response(conn, 200) =~ "Contact me"
    end
  end
end
