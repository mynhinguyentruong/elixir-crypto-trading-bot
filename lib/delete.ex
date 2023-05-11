defmodule Delete do
  use Application
  @moduledoc """
  Documentation for `Delete`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Delete.hello()
      :world

  """
  def hello do
    :world
  end

  def start(_, _) do
    children = []
    opts = [strategy: :one_for_one]
  end
end
