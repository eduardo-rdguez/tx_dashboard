defmodule TxDashboardWeb.Balance.BalanceLive do
  use TxDashboardWeb, :live_view

  alias TxDashboard.Dashboard.Transactions

  @impl true
  def mount(%{"account_number" => account_number} = _params, _session, socket) do
    transactions = Transactions.list_transactions()
    {:ok, assign(socket, account_number: account_number, transactions: transactions)}
  end
end
