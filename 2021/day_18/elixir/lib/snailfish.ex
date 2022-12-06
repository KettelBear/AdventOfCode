defmodule Snailfish do
  def part1() do
    parse_input("input.test")
    |> IO.inspect()
  end

  def part2(), do: true

  defp add_sn(numbers), do: add_sn(hd(numbers), tl(numbers))
  defp add_sn(acc, []), do: acc
  defp add_sn(acc, [sn | numbers]) do
    [acc, sn]
    |> reduce()
    |> add_sn(numbers)
  end

  defp reduce(snailnumber), do: reduce([], snailnumber)
  defp reduce(acc, true), do: acc
  defp reduce(acc, sn) do
    sn
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split("\r\n", trim: true)
    |> Enum.map(&Code.eval_string(&1) |> elem(0))
  end
end
