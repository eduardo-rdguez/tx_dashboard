defmodule TxDashboard.Schema.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias TxDashboard.Schema.Transaction
  alias TxDashboard.Schema.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :amount, :float
    field :concept, :string
    field :currency, :string
    field :origin, :string
    field :type, :string
    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :origin, :concept, :amount, :currency, :account_id])
    |> validate_required([:type, :origin, :concept, :amount, :currency, :account_id])
    |> foreign_key_constraint(:account_id)
  end

  def assoc_account(%Account{} = account, params \\ %{}) do
    account
    |> Ecto.build_assoc(:transactions, params)
  end

  def by_account_number(account_number) do
    Transaction
    |> join(:inner, [a], assoc(a, :account), as: :account)
    |> where([account: a], a.account == ^account_number)
    |> order_by([desc: :inserted_at])
  end
end
