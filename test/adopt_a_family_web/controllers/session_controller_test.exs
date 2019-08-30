defmodule AdoptAFamilyWeb.PageControllerTest do
  use AdoptAFamilyWeb.ConnCase

  test "GET /login", %{conn: conn} do
    conn = get(conn, "/login")
    assert html_response(conn, 200) =~ "LOGIN"
  end

  setup(context) do
    {:ok, user} = AdoptAFamily.Accounts.create_user(%{
      email: "valid@email.com",
      username: "username",
      name: "name",
      password: "password",
      password_confirmation: "password"
    })
    Map.put(context, :user, user)
  end

  describe "POST /login" do
    test "with valid credentials", %{conn: conn, user: user} do
      conn = post(conn, "/login", session: %{
        username: user.username,
        password: user.password
      })
      assert get_session(conn) == %{"phoenix_flash" => %{"info" => "Signed in successfully."}, "current_user_id" => user.id}
      assert redirected_to(conn) == Routes.page_path(conn, :index)
    end

    test "with invalid credentials", %{conn: conn, user: user} do
      conn = post(conn, "/login", session: %{
        username: user.username,
        password: "Bad password"
      })
      assert html_response(conn, 200) =~ "There was a problem with your username/password"
    end
  end

  describe "DELETE /logout" do
    setup(%{user: user} = context) do
      session_conn = put_session(session_conn(), :current_user_id, user.id)
      %{context | conn: session_conn}
    end

    test "DELETE /logout", %{conn: conn} do
      conn = delete(conn, "/logout")
      assert get_session(conn) == %{"phoenix_flash" => %{"info" => "Signed out successfully."}}
      assert redirected_to(conn) == Routes.session_path(conn, :new)
    end
  end
end
