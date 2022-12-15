defmodule Advent.Day.Thirteen do
  @moduledoc false

  defdelegate code(string), to: Code, as: :string_to_quoted!

  alias Advent.Utility

  @doc """
  Determine which pairs of packets are already in the right order. What is the
  sum of the indices of those pairs?
  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true)
    |> Enum.map(fn [one, two] -> [code(one), code(two)] end)
    |> Enum.with_index(1)
    |> correct_order()
  end

  defp correct_order(signals) do
    Enum.reduce(signals, 0, fn {[one, two], idx}, acc ->
      if correct?(one, two), do: acc + idx, else: acc
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
    |> Enum.map(&Code.string_to_quoted!/1)
    |> Enum.concat([[[2]], [[6]]])
    |> Enum.sort(fn one, two -> correct?(one, two) end)
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

  defp correct?([], []), do: nil
  defp correct?([], _), do: true
  defp correct?(_, []), do: false
  defp correct?([one], [two]), do: correct?(one, two)
  defp correct?(o, t) when is_integer(o) and is_list(t), do: correct?([o], t)
  defp correct?(o, t) when is_list(o) and is_integer(t), do: correct?(o, [t])
  defp correct?([o | one], [t | two]) do
    case correct?(o, t) do
      nil -> correct?(one, two)
      boolean -> boolean
    end
  end
  defp correct?(one, two), do: if one == two, do: nil, else: one < two

end
