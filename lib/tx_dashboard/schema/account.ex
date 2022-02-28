defmodule TxDashboard.Schema.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :account, :string
    field :last_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :last_name, :account])
    |> validate_required([:name, :last_name, :account])
  end
end
