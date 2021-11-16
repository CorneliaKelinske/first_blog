defmodule FirstBlogWeb.ContactControllerTest do
  use FirstBlogWeb.ConnCase

  @valid_params %{
    from_email: "tester@test.com",
    name: "testy McTestface",
    subject: "Testing, testing",
    message: "Hello, this is a test",
    answer: "ngcgT",
    not_a_robot: "ngcgT",
    image: "iVBORw0KGgoAAAANSUhEUgAAANwAAAB4CAAAAAC8vMOlAAAaRklEQVR4nIVce/BuVVl+3u"
  }

  @invalid_params %{
    from_email: "tester@test.com",
    name: nil,
    subject: "Testing, testing",
    message: "Hello, this is a test",
    answer: "ngcgT",
    not_a_robot: "ngcgT",
    image: "iVBORw0KGgoAAAANSUhEUgAAANwAAAB4CAAAAAC8vMOlAAAaRklEQVR4nIVce/BuVVl+3u"
  }

  @incorrect_answer %{
    from_email: "tester@test.com",
    name: "testy McTestface",
    subject: "Testing, testing",
    message: "Hello, this is a test",
    answer: "xyz",
    not_a_robot: "ngcgT",
    image: "iVBORw0KGgoAAAANSUhEUgAAANwAAAB4CAAAAAC8vMOlAAAaRklEQVR4nIVce/BuVVl+3u"
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

    test "renders contact page again, if captcha answer entered is incorrect ", %{
      conn: conn
    } do
      conn = post(conn, Routes.contact_path(conn, :create), content: @incorrect_answer)

      assert html_response(conn, 200) =~ "Contact me"
    end
  end
end
