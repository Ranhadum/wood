defmodule Wood.PageControllerTest do
  use Wood.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Witaj w Phoenix!"
  end
end
