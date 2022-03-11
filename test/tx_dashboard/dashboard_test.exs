defmodule TxDashboard.DashboardTest do
  use TxDashboard.DataCase

  alias TxDashboard.Dashboard.Accounts
  alias TxDashboard.Dashboard.Transactions

  describe "accounts" do
    alias TxDashboard.Schema.Account

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{account: nil, last_name: nil, name: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{account: "some account", last_name: "some last_name", name: "some name"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.account == "some account"
      assert account.last_name == "some last_name"
      assert account.name == "some name"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{account: "some updated account", last_name: "some updated last_name", name: "some updated name"}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.account == "some updated account"
      assert account.last_name == "some updated last_name"
      assert account.name == "some updated name"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end

  describe "transactions" do
    alias TxDashboard.Schema.Transaction

    import TxDashboard.DashboardFixtures

    @invalid_attrs %{amount: nil, concept: nil, currency: nil, origin: nil, type: nil}

    test "list_transactions/0 returns all transactions" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      account = account_fixture()
      valid_attrs = %{account_id: account.id, amount: 120.5, concept: "some concept", currency: "some currency", origin: "some origin", type: "some type"}

      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(valid_attrs)
      assert transaction.amount == 120.5
      assert transaction.concept == "some concept"
      assert transaction.currency == "some currency"
      assert transaction.origin == "some origin"
      assert transaction.type == "some type"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      update_attrs = %{amount: 456.7, concept: "some updated concept", currency: "some updated currency", origin: "some updated origin", type: "some updated type"}

      assert {:ok, %Transaction{} = transaction} = Transactions.update_transaction(transaction, update_attrs)
      assert transaction.amount == 456.7
      assert transaction.concept == "some updated concept"
      assert transaction.currency == "some updated currency"
      assert transaction.origin == "some updated origin"
      assert transaction.type == "some updated type"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      assert {:error, %Ecto.Changeset{}} = Transactions.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      account = account_fixture()
      transaction = transaction_fixture(account.id)
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
