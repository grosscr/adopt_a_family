defmodule AdoptAFamilyWeb.PageController do
  use AdoptAFamilyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
