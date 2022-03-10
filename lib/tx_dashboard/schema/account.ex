defmodule TxDashboard.Schema.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias TxDashboard.Schema.Transaction
  alias TxDashboard.Schema.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :account, :string
    field :last_name, :string
    field :name, :string
    has_many :transactions, Transaction

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :last_name, :account])
    |> validate_required([:name, :last_name, :account])
  end

  def by_account_number(account_number) do
    Account
    |> where([account: ^account_number])
  end
end
