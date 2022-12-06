defmodule Sonar do
  @moduledoc """
  Solutions for Day 1 for Advent of Code in Elixir.
  """

  @doc """
  Checks for increasing depths with each sonar reading
  that is provided from the scanner.
  """
  def part1() do
    parse_input("input.prod")
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  @doc """
  Instead of summing values, since each window contains two
  of the same number, we can simply compare the size of the
  two numbers unique to each window. The number that is
  larger means it has a bigger sum.
  """
  def part2() do
    parse_input("input.prod")
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.count(fn [a, _b, _c, d] -> d > a end)
  end

  defp parse_input(in_file) do
    in_file
    |> File.read!()
    |> String.split("\r\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
