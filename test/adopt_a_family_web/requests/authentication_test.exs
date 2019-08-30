defmodule AdoptAFamilyWeb.AuthenticationTest do
  use AdoptAFamilyWeb.ConnCase

  describe "Logged in user" do
    test "GET /login", %{auth_conn: conn} do
      response = get(conn, "/login")
      assert redirected_to(response) == Routes.page_path(response, :index)
    end

    test "POST /login", %{auth_conn: conn} do
      response = post(conn, "/login", session: %{})
      assert redirected_to(response) == Routes.page_path(response, :index)
    end

    test "GET /register/new", %{auth_conn: conn} do
      response = get(conn, "/register/new")
      assert redirected_to(response) == Routes.page_path(response, :index)
    end

    test "POST /register", %{auth_conn: conn} do
      response = post(conn, "/register", user: %{})
      assert redirected_to(response) == Routes.page_path(response, :index)
    end
  end

  describe "Guest user" do
    test "GET /", %{conn: conn} do
      response = get(conn, "/")
      assert redirected_to(response) == Routes.session_path(response, :new)
    end

    test "GET /profile/:id/edit", %{conn: conn, staged_user: user} do
      response = get(conn, "/profile/#{user.id}/edit")
      assert redirected_to(response) == Routes.session_path(response, :new)
    end

    test "PATCH /profile/:id", %{conn: conn, staged_user: user} do
      response = patch(conn, "/profile/#{user.id}", %{})
      assert redirected_to(response) == Routes.session_path(response, :new)
    end

    test "DELETE /profile/:id", %{conn: conn, staged_user: user} do
      response = delete(conn, "/profile/#{user.id}")
      assert redirected_to(response) == Routes.session_path(response, :new)
    end

    test "DELETE /logout", %{conn: conn} do
      response = delete(conn, "/logout")
      assert redirected_to(response) == Routes.session_path(response, :new)
    end
  end
end
