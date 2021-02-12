defmodule AdoptAFamilyWeb.FamilyControllerTest do
  use AdoptAFamilyWeb.ConnCase
  import Phoenix.LiveViewTest

  alias AdoptAFamily.Families

  describe "index" do
    test "lists all families", %{auth_conn: conn} do
      conn = get(conn, Routes.family_path(conn, :index))
      assert html_response(conn, 200) =~ "Families"
    end
  end

  describe "show family" do
    setup [:create_family]

    test "shows the head of house", %{auth_conn: conn, family: f} do
      conn = get(conn, Routes.family_path(conn, :show, f))
      assert html_response(conn, 200) =~ "#{f.head_of_house} Family"
    end
  end

  # describe "new family" do
    # test "renders form", %{conn: conn} do
      # conn = get(conn, Routes.family_path(conn, :new))
      # assert html_response(conn, 200) =~ "New Family"
    # end
  # end

  # describe "create family" do
    # test "redirects to show when data is valid", %{conn: conn} do
      # conn = post(conn, Routes.family_path(conn, :create), family: @create_attrs)

      # assert %{id: id} = redirected_params(conn)
      # assert redirected_to(conn) == Routes.family_path(conn, :show, id)

      # conn = get(conn, Routes.family_path(conn, :show, id))
      # assert html_response(conn, 200) =~ "Show Family"
    # end

    # test "renders errors when data is invalid", %{conn: conn} do
      # conn = post(conn, Routes.family_path(conn, :create), family: @invalid_attrs)
      # assert html_response(conn, 200) =~ "New Family"
    # end
  # end

  # describe "edit family" do
    # setup [:create_family]

    # test "renders form for editing chosen family", %{conn: conn, family: family} do
      # conn = get(conn, Routes.family_path(conn, :edit, family))
      # assert html_response(conn, 200) =~ "Edit Family"
    # end
  # end

  # describe "update family" do
    # setup [:create_family]

    # test "redirects when data is valid", %{conn: conn, family: family} do
      # conn = put(conn, Routes.family_path(conn, :update, family), family: @update_attrs)
      # assert redirected_to(conn) == Routes.family_path(conn, :show, family)

      # conn = get(conn, Routes.family_path(conn, :show, family))
      # assert html_response(conn, 200)
    # end

    # test "renders errors when data is invalid", %{conn: conn, family: family} do
      # conn = put(conn, Routes.family_path(conn, :update, family), family: @invalid_attrs)
      # assert html_response(conn, 200) =~ "Edit Family"
    # end
  # end

  defp create_family(_) do
    {:ok, family} = Families.create_family(%{head_of_house: "Head of House", clinician: "Clinician"})
    {:ok, child} = Families.add_child(family, %{name: "John", age: 10, gender: "male"})
    {:ok, gift1} = Families.add_gift(child, %{item: "Soccer Ball"})
    {:ok, gift2} = Families.add_gift(child, %{item: "Soccer Cleats", size: "Child's 10"})
    {:ok, %{family: family, child: child, gifts: [gift1, gift2]}}
  end
end
