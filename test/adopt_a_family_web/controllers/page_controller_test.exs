defmodule AdoptAFamilyWeb.PageControllerTest do
  use AdoptAFamilyWeb.ConnCase

  test "GET /", %{auth_conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200)
  end
end
