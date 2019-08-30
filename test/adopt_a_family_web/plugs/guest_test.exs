defmodule AdoptAFamily.Plugs.GuestTest do
  use AdoptAFamilyWeb.ConnCase

  alias AdoptAFamilyWeb.Plugs.Guest

  test "redirects user if logged in", %{auth_conn: conn} do
    new_conn = Guest.call(conn, %{})
    assert redirected_to(new_conn) == "/"
  end

  test "returns the conn if not logged in", %{session_conn: conn} do
    new_conn = Guest.call(conn, %{})
    assert new_conn == conn
  end
end
