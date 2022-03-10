defmodule TxDashboardWeb.Balance.BalanceLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard.Transactions
  alias TxDashboard.Schema.Transaction

  @topic "transactions"
  @size_pages [5, 10, 15]

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    Phoenix.PubSub.subscribe(TxDashboard.PubSub, @topic <> ":" <> account_number)

    socket =
      socket
      |> assign(
        account_number: account_number,
        transactions: [],
        size_pages: @size_pages
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, %{assigns: %{account_number: account_number}} = socket) do
    page_params = page_params(params)
    page = Transactions.list_by_account_number(account_number, page_params)
    page_params = page_params |> Map.put(:total_pages, page.total_pages)

    socket =
      socket
      |> assign(:transactions, page.entries)
      |> assign(:page_params, page_params)

    {:noreply, socket}
  end

  @impl true
  def handle_info(%Transaction{} = transaction, socket) do
    socket =
      socket
      |> update(:transactions, &[transaction | &1])

    {:noreply, socket}
  end

  @impl true
  def handle_event("paginate", %{"page" => page}, socket) do
    socket =
      socket.assigns.page_params
      |> Map.replace!(:page, String.to_integer(page))
      |> push_params(socket)

    {:noreply, socket}
  end

  defp page_params(params) do
    %{
      page: String.to_integer(params["page"] || "1"),
      page_size: String.to_integer(params["page_size"] || "5")
    }
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
