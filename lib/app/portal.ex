defmodule Portal.Door do
  use Agent

  def start_link(color) when is_atom(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  def push(door, item) do
    Agent.update(door, fn list -> [item | list] end)
  end

  def pop(door) do
    Agent.get_and_update(door, fn list ->
      case list do
        [head | tail] -> {{:ok, head}, tail} # Format: { return_value, new_state}
        [] -> {:error, []}
      end
    end)
  end

  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  def stop(door) do
    Agent.stop(door)
  end
end
