defmodule TxDashboardWeb.TransactionLiveTest do
  use TxDashboardWeb.ConnCase

  import Phoenix.LiveViewTest
  import TxDashboard.DashboardFixtures

  @create_attrs %{amount: 120.5, concept: "some concept", currency: "some currency", origin: "some origin", type: "some type"}
  @update_attrs %{amount: 456.7, concept: "some updated concept", currency: "some updated currency", origin: "some updated origin", type: "some updated type"}
  @invalid_attrs %{amount: nil, concept: nil, currency: nil, origin: nil, type: nil}

  defp create_transaction(_) do
    account = account_fixture()
    transaction = transaction_fixture(account.id)
    %{transaction: transaction}
  end

  describe "Index" do
    setup [:create_transaction]

    @tag :skip
    test "lists all transactions", %{conn: conn, transaction: transaction} do
      {:ok, _index_live, html} = live(conn, Routes.transaction_path(conn, :index))

      assert html =~ "Listing Transactions"
      assert html =~ transaction.concept
    end

    @tag :skip
    test "saves new transaction", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_path(conn, :index))

      assert index_live |> element("a", "New Transaction") |> render_click() =~
               "New Transaction"

      assert_patch(index_live, Routes.transaction_path(conn, :new))

      assert index_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transaction-form", transaction: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_path(conn, :index))

      assert html =~ "Transaction created successfully"
      assert html =~ "some concept"
    end

    @tag :skip
    test "updates transaction in listing", %{conn: conn, transaction: transaction} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_path(conn, :index))

      assert index_live |> element("#transaction-#{transaction.id} a", "Edit") |> render_click() =~
               "Edit Transaction"

      assert_patch(index_live, Routes.transaction_path(conn, :edit, transaction))

      assert index_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#transaction-form", transaction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_path(conn, :index))

      assert html =~ "Transaction updated successfully"
      assert html =~ "some updated concept"
    end

    @tag :skip
    test "deletes transaction in listing", %{conn: conn, transaction: transaction} do
      {:ok, index_live, _html} = live(conn, Routes.transaction_path(conn, :index))

      assert index_live |> element("#transaction-#{transaction.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#transaction-#{transaction.id}")
    end
  end

  describe "Show" do
    setup [:create_transaction]

    @tag :skip
    test "displays transaction", %{conn: conn, transaction: transaction} do
      {:ok, _show_live, html} = live(conn, Routes.transaction_path(conn, :show, transaction))

      assert html =~ "Show Transaction"
      assert html =~ transaction.concept
    end

    @tag :skip
    test "updates transaction within modal", %{conn: conn, transaction: transaction} do
      {:ok, show_live, _html} = live(conn, Routes.transaction_path(conn, :show, transaction))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Transaction"

      assert_patch(show_live, Routes.transaction_path(conn, :edit, transaction))

      assert show_live
             |> form("#transaction-form", transaction: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#transaction-form", transaction: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.transaction_path(conn, :show, transaction))

      assert html =~ "Transaction updated successfully"
      assert html =~ "some updated concept"
    end
  end
end
