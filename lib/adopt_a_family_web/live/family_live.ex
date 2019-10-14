defmodule AdoptAFamily.FamilyLive do
  use Phoenix.LiveView

  def mount(params, socket) do
    {:ok, assign(socket, params)}
  end

  def render(assigns) do
    Phoenix.View.render(AdoptAFamilyWeb.FamilyView, "show.html", assigns)
  end
end
