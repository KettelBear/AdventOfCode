defmodule Diagnostics do
  @moduledoc """
  Solutions for Day 3 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 gets the frequencies from the columns of the bits. The more
  frequent the bit then that is what goes in that column for gamma,
  while epsilon is just the inverse.
  """
  def part1() do
    digits =
      parse_input("input.prod")
      |> Enum.map(&String.graphemes/1)

    digit_len = digits |> hd() |> Enum.count()
    gamma = for i <- 0..(digit_len - 1) do
      digits |> column(i) |> most_common()
    end

    epsilon = gamma |> invert() |> to_base_ten()
    gamma = gamma |> to_base_ten()

    gamma * epsilon
  end

  @doc """
  In part 2, we simply filter out the less common bit words for each
  column to get the oxygen reading, and filter out the more common bit
  words for each column for the carbon dioxide reading.
  """
  def part2() do
    digits =
      parse_input("input.prod")
      |> Enum.map(&String.graphemes/1)

    oxy =
      digits
      |> filter_grid(&most_common/1)
      |> to_base_ten()

    co2 =
      digits
      |> filter_grid(&least_common/1)
      |> to_base_ten()

    oxy * co2
  end

  defp filter_grid(digits, predicate, search_col \\ 0)
  defp filter_grid([num], _predicate, _search_col), do: num
  defp filter_grid(digits, predicate, search_col) do
    column = column(digits, search_col)
    keep = predicate.(column)

    filtered_digits = Enum.filter(digits, fn list ->
      Enum.at(list, search_col) == keep
    end)
    filter_grid(filtered_digits, predicate, search_col + 1)
  end

  defp invert("1"), do: "0"
  defp invert("0"), do: "1"
  defp invert(digits) when is_list(digits) do
    digits
    |> Enum.map(&invert/1)
  end

  defp to_base_ten(binary_digits) do
    binary_digits
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp column(matrix, index) do
    matrix
    |> Enum.map(fn row -> Enum.at(row, index) end)
    |> Enum.reject(&is_nil/1)
  end

  defp most_common(digits) do
    %{"1" => ones, "0" => zeroes} = Enum.frequencies(digits)
    if ones >= zeroes, do: "1", else: "0"
  end

  defp least_common(digits) do
    %{"1" => ones, "0" => zeroes} = Enum.frequencies(digits)
    if ones < zeroes, do: "1", else: "0"
  end

  defp parse_input(in_file) do
    in_file
    |> File.read!()
    |> String.split("\r\n", trim: true)
  end
end
