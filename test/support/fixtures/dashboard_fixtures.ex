defmodule TxDashboard.DashboardFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TxDashboard.Dashboard` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        account: "some account",
        last_name: "some last_name",
        name: "some name"
      })
      |> TxDashboard.Dashboard.create_account()

    account
  end
end
