defmodule Dive do
  @moduledoc """
  Solutions for Day 2 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 instructions where moderatly simple; If the instruction was `forward`
  increase the horizontal distance by the value provided. Otherwise, if it was
  `down` increase the depth and for `up` decrease the depth.
  """
  def part1() do
    parse_input("input.prod")
    |> Enum.reduce({0, 0}, &drive/2)
    |> Tuple.product()
  end

  defp drive({:forward, amount}, {dist, depth}), do: {dist + amount, depth}
  defp drive({:down, amount}, {dist, depth}), do: {dist, depth + amount}
  defp drive({:up, amount}, {dist, depth}), do: {dist, depth - amount}

  @doc """
  For each down and up, adjust the aim accordingly. When forward is the instruction
  increase the horizontal distance by the value, and the depth by the value multiplied
  by the current value for `aim`
  """
  def part2() do
      parse_input("input.prod")
      |> Enum.reduce({0, 0, 0}, &aim/2)
      |> then(fn {dist, depth, _aim} -> dist * depth end)
  end

  defp aim({:forward, amount}, {dist, depth, aim}), do: {dist + amount, depth + aim * amount, aim}
  defp aim({:down, amount}, {dist, depth, aim}), do: {dist, depth, aim + amount}
  defp aim({:up, amount}, {dist, depth, aim}), do: {dist, depth, aim - amount}

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split("\n", trim: true)
    |> Enum.map(&directions/1)
  end

  defp directions("forward " <> n), do: {:forward, stoi(n)}
  defp directions("down " <> n), do: {:down, stoi(n)}
  defp directions("up " <> n), do: {:up, stoi(n)}

  defp stoi(n), do: String.to_integer(n)
end
