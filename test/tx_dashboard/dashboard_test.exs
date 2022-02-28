defmodule TxDashboard.DashboardTest do
  use TxDashboard.DataCase

  alias TxDashboard.Dashboard

  describe "accounts" do
    alias TxDashboard.Dashboard.Account

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{account: nil, last_name: nil, name: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Dashboard.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Dashboard.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{account: "some account", last_name: "some last_name", name: "some name"}

      assert {:ok, %Account{} = account} = Dashboard.create_account(valid_attrs)
      assert account.account == "some account"
      assert account.last_name == "some last_name"
      assert account.name == "some name"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{account: "some updated account", last_name: "some updated last_name", name: "some updated name"}

      assert {:ok, %Account{} = account} = Dashboard.update_account(account, update_attrs)
      assert account.account == "some updated account"
      assert account.last_name == "some updated last_name"
      assert account.name == "some updated name"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_account(account, @invalid_attrs)
      assert account == Dashboard.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Dashboard.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_account(account)
    end
  end
end
