defmodule Advent.Day.Thirteen do
  @moduledoc false

  defdelegate code!(string), to: Code, as: :string_to_quoted!

  alias Advent.Utility

  @doc """
  Determine which pairs of packets are already in the right order. What is the
  sum of the indices of those pairs?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true)
    |> Enum.map(fn [one, two] -> [code!(one), code!(two)] end)
    |> Enum.with_index(1)
    |> correct_order()
  end

  defp correct_order(signals) do
    Enum.reduce(signals, 0, fn {[one, two], idx}, acc ->
      if comp(one, two) == :lt, do: acc + idx, else: acc
    end)
  end

  @doc """
  Organize all of the packets into the correct order. What is the decoder key
  for the distress signal?
  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!()
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&code!/1)
    |> Enum.concat([[[2]], [[6]]])
    |> Enum.sort(fn one, two -> comp(one, two) == :lt end)
    |> Enum.with_index(1)
    |> Enum.reduce_while(1, &dividers/2)
  end

  defp dividers({[[2]], idx}, acc), do: {:cont, acc * idx}
  defp dividers({[[6]], idx}, acc), do: {:halt, acc * idx}
  defp dividers(_, acc), do: {:cont, acc}

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################

  defp comp([], []), do: :eq
  defp comp([], _), do: :lt
  defp comp(_, []), do: :gt
  defp comp([one], [two]), do: comp(one, two)
  defp comp(o, t) when is_integer(o) and is_list(t), do: comp([o], t)
  defp comp(o, t) when is_list(o) and is_integer(t), do: comp(o, [t])
  defp comp([o | one], [t | two]) do
    case comp(o, t) do
      :eq -> comp(one, two)
      comparator -> comparator
    end
  end
  defp comp(one, two) do
    cond do
      one > two -> :gt
      one < two -> :lt
      true -> :eq
    end
  end
end
