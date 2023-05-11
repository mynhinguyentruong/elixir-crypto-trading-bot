defmodule Portal do
  defstruct [:left, :right]
  # %Portal{left: :blue, right: :green}

  def shoot(color) when is_atom(color) do
    Portal.Door.start_link(color)
  end

  def transfer(left_color, right_color, data) do
    for item <- data do
      Portal.Door.push(left_color, item)
    end
    %Portal{left: left_color, right: right_color}
  end

  def push_right(portal) do
    {:ok, item} = Portal.Door.pop(portal.left)
    Portal.Door.push(portal.right, item)
  end
end

