defmodule Display do
  @moduledoc """
  Solutions for Day 8 for Advent of Code in Elixir.
  """

  @doc """
  Part 1 merely asks to scan the outputs of each line
  and find the digits with the unique number of sections lit up.
  That includes the numbers, 1, 4, 7, and 8.
  """
  def part1() do
    parse_input("input.prod")
    |> Enum.reduce(0, fn [_input, output], acc ->
      output
      |> String.split(" ", trim: true)
      |> Enum.count(fn code -> String.length(code) in [2, 3, 4, 7] end)
      |> Kernel.+(acc)
    end)
  end

  @doc """
  Part 2 asks to decode each of the input lines to determine
  the digits of the outputs, then sum together all of the
  outputs.
  """
  def part2() do
    parse_input("input.prod")
    |> decode_wires()
    |> sum_outputs()
  end

  defp sum_outputs(codes) do
    codes
    |> Enum.reduce(0, fn {decoded, outs}, acc ->
      inverted = Map.new(decoded, fn {key, value} -> {value, key} end)

      outs
      |> Enum.map(fn value -> Map.get(inverted, value) end)
      |> Enum.join("")
      |> String.to_integer()
      |> Kernel.+(acc)
    end)
  end

  defp decode_wires(inputs) do
    inputs
    |> Enum.map(fn [ins, outs] -> [split_codes(ins), split_codes(outs)] end)
    |> Enum.map(fn [ins, outs] ->
      decoded = decode(ins)

      {decoded, outs}
    end)
  end

  defp split_codes(code_str) do
    code_str
    |> String.split(" ", trim: true)
    |> Enum.map(&sort_codes/1)
  end

  defp sort_codes(code) do
    code
    |> String.graphemes()
    |> Enum.sort()
    |> Enum.join()
  end

  defp decode(ins) do
    digit_map =
      ins
      |> Enum.reduce(%{}, fn value, acc ->
        len = String.length(value)
        cond do
          len == 2 -> Map.put(acc, 1, value)
          len == 3 -> Map.put(acc, 7, value)
          len == 4 -> Map.put(acc, 4, value)
          len == 7 -> Map.put(acc, 8, value)
          true -> acc
        end
      end)

    ins
    |> Enum.reduce(digit_map, fn value, acc ->
      len = String.length(value)
      cond do
        len == 5 ->
          cond do
            diff(Map.get(acc, 1), value) == 3 -> Map.put(acc, 3, value)
            diff(Map.get(acc, 4), value) == 2 -> Map.put(acc, 5, value)
            true -> Map.put(acc, 2, value)
          end
        len == 6 ->
          cond do
            same(Map.get(acc, 1), value) == 1 -> Map.put(acc, 6, value)
            same(Map.get(acc, 4), value) == 4 -> Map.put(acc, 9, value)
            true -> Map.put(acc, 0, value)
          end
        true -> acc
      end
    end)
  end

  defp diff(known, unknown) do
    unknown
    |> String.graphemes()
    |> Kernel.--(String.graphemes(known))
    |> Enum.count()
  end

  defp same(known, unknown) do
    MapSet.intersection(
      unknown |> String.graphemes() |> MapSet.new(),
      known |> String.graphemes() |> MapSet.new()
    )
    |> Enum.count()
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split([" | ", "\n"], trim: true)
    |> Enum.chunk_every(2)
  end
end
