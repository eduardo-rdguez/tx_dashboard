defmodule TxDashboard.Util.JsonUtil do
  @moduledoc """
  Documentation for `TxDashboard.Util.JsonUtil`.
  """

  @doc """
  Receive a json string and return a map.
  """
  @spec decode(String.t()) :: map()
  def decode(json_encoded) do
    Jason.decode!(json_encoded)
  end
end
