defmodule AdoptAFamilyWeb.UserControllerTest do
  use AdoptAFamilyWeb.ConnCase

  @create_attrs %{email: "valid@email.com", password: "some password", password_confirmation: "some password", name: "some name", username: "some_username"}
  @update_attrs %{email: "updated@email.com", name: "some updated name", password: "password", password_confirmation: "password"}
  @invalid_attrs %{email: nil}

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to root when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below."
    end
  end

  describe "edit user" do
    test "renders form for editing chosen user", %{auth_conn: conn, staged_user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    test "redirects to root when data is valid", %{auth_conn: conn, staged_user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "renders errors when data is invalid", %{auth_conn: conn, staged_user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below."
    end
  end

  describe "delete user" do
    test "deletes chosen user", %{auth_conn: conn, staged_user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.page_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :edit, user))
      end
    end
  end
end
