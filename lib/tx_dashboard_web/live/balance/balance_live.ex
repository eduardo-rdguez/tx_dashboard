defmodule TxDashboardWeb.Balance.BalanceLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard.Transactions

  @topic "transactions"

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    Phoenix.PubSub.subscribe(TxDashboard.PubSub, @topic <> ":" <> account_number)
    transactions = Transactions.find_all_by_account_number(account_number)

    {:ok, assign(socket, account_number: account_number, transactions: transactions)}
  end

  @impl true
  def handle_info(message, socket) do
    IO.inspect(message)
    {:noreply, socket}
  end
end
