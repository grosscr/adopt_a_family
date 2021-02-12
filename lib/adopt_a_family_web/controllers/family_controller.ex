defmodule AdoptAFamilyWeb.FamilyController do
  use AdoptAFamilyWeb, :controller

  alias AdoptAFamily.Families
  alias AdoptAFamily.Families.{Child, Family, Gift}

  def index(conn, _params) do
    render(conn, "index.html", families: Families.all())
  end

  def new(conn, _params) do
    changeset = Families.change_family(%Family{
      children: [%Child{gifts: [%Gift{}]}]
        })
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"family" => family_params}) do
    case Families.create_family(family_params) do
      {:ok, family} ->
        conn
        |> put_flash(:info, "Family created successfully.")
        |> redirect(to: Routes.family_path(conn, :show, family))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => family_id}) do
    live_render(conn, AdoptAFamily.FamilyLive, session: %{
      family: Families.get_family(family_id),
      children: Families.children_from_family(family_id),
      current_user_id: get_session(conn, :current_user_id)
    })
  end

  # def edit(conn, %{"id" => id}) do
    # family = Families.get_family!(id)
    # changeset = Families.change_family(family)
    # render(conn, "edit.html", family: family, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "family" => family_params}) do
    # family = Families.get_family!(id)

    # case Families.update_family(family, family_params) do
      # {:ok, family} ->
        # conn
        # |> put_flash(:info, "Family updated successfully.")
        # |> redirect(to: Routes.family_path(conn, :show, family))

      # {:error, %Ecto.Changeset{} = changeset} ->
        # render(conn, "edit.html", family: family, changeset: changeset)
    # end
  # end
end
