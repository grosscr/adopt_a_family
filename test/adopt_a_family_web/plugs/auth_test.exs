defmodule AdoptAFamily.Plugs.AuthTest do
  use AdoptAFamilyWeb.ConnCase

  alias AdoptAFamilyWeb.Plugs.Auth

  test "redirects user if not logged in", %{session_conn: conn} do
    conn = Auth.call(conn, %{})
    assert redirected_to(conn) == "/login"
  end

  test "assigns current user to connection if logged in", %{auth_conn: conn, staged_user: user} do
    conn = Auth.call(conn, %{})
    assert %{current_user: assigned_user} = conn.assigns
    assert assigned_user.username == user.username
    assert conn.status != 302
  end
end
