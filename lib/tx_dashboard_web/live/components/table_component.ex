defmodule TxDashboardWeb.Components.TableComponent do
  use TxDashboardWeb, :live_component

  @size_pages [5, 10, 15]

  @impl true
  def mount(socket) do
    socket =
      socket
      |> assign(:size_pages, @size_pages)

    {:ok, socket}
  end
end
