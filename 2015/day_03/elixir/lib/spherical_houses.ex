defmodule SphericalHouses do
  @moduledoc """
  Santa is delivering presents to an infinite two-dimensional grid of houses.

  He begins by delivering a present to the house at his starting location, and
  then an elf at the North Pole calls him via radio and tells him where to
  move next. Moves are always exactly one house to the north (^), south (v),
  east (>), or west (<). After each move, he delivers another present to the
  house at his new location.
  """

  @doc """
  How many houses receive at least one present?
  """
  def part1() do
    parse_input("input.prod")
    |> Enum.reduce({%{{0,0} => 1}, {0, 0}}, &follow_directions/2)
    |> count_houses()
  end

  defp follow_directions(direction, {map, point}) do
    point = move(direction, point)
    {deliver_present(point, map), point}
  end

  @doc """
  Santa and Robo-Santa start at the same location (delivering two presents to
  the same starting house), then take turns moving based on instructions from
  the elf, who is eggnoggedly reading from the same script as the previous
  year.
  This year, how many houses receive at least one present?
  """
  def part2() do
    parse_input("input.prod")
    |> Enum.reduce({%{{0, 0} => 2}, {0, 0}, {0, 0}, true}, &robot_help/2)
    |> count_houses()
  end

  defp robot_help(direction, {map, santa, robot, santa?}) do
    if santa? do
      point = move(direction, santa)
      {deliver_present(point, map), point, robot, not santa?}
    else
      point = move(direction, robot)
      {deliver_present(point, map), santa, point, not santa?}
    end
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.graphemes()
  end

  defp deliver_present(point, map), do: Map.update(map, point, 1, &(&1 + 1))

  defp move("^", {row, col}), do: {row + 1, col}
  defp move(">", {row, col}), do: {row, col + 1}
  defp move("v", {row, col}), do: {row - 1, col}
  defp move("<", {row, col}), do: {row, col - 1}

  defp count_houses(acc), do: acc |> elem(0) |> map_size()
end
