defmodule TxDashboardWeb.Balance.Components.BalanceTableComponent do
  use TxDashboardWeb, :live_component

  @impl true
  def handle_event("paginate", %{"page" => page}, socket) do
    socket =
      socket.assigns.page_params
      |> Map.replace!(:page, String.to_integer(page))
      |> push_params(socket)

    {:noreply, socket}
  end

  @impl true
  def handle_event("select-page-size", %{"page-size" => page_size}, socket) do
    socket =
      socket.assigns.page_params
      |> Map.replace!(:page_size, String.to_integer(page_size))
      |> push_params(socket)

    {:noreply, socket}
  end

  defp push_params(page_params, %{assigns: %{account_number: account_number}} = socket) do
    push_patch(socket,
      to:
        Routes.balance_path(
          socket,
          :index,
          account_number,
          page: page_params.page,
          page_size: page_params.page_size
        )
    )
  end
end
