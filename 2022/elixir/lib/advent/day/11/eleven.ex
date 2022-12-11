defmodule Advent.Day.Eleven do
  @moduledoc false

  defdelegate stoi(str), to: String, as: :to_integer

  defmodule Monkey do
    defstruct [:operation, :test, :pass, :fail, inspects: 0, items: []]
  end

  alias Advent.Day.Eleven.Monkey
  alias Advent.Utility

  @doc """

  """
  def part1 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true)
    |> build_monkeys()
    |> keep_away(20, false)
    |> level_of_monkey_business()
  end

  @doc """

  """
  def part2 do
    "#{__DIR__}/input.prod"
    |> Utility.parse_input!(double: true)
    |> build_monkeys()
    |> keep_away(10_000, true)
    |> level_of_monkey_business()
  end

  ##############################
  #                            #
  #     Used By Both Parts     #
  #                            #
  ##############################

  defp level_of_monkey_business(monkeys) do
    monkeys
    |> Enum.sort_by(fn {_, monkey} -> monkey.inspects end, :desc)
    |> Enum.take(2)
    |> then(fn [{_, m1}, {_, m2}] -> m1.inspects * m2.inspects end)
  end

  defp keep_away(monkey_map, rounds, manage?) do
    Enum.reduce(1..rounds, monkey_map, fn _, monkeys ->
      play_round(monkeys, manage?)
    end)
  end

  defp play_round(monkeys, manage?) do
    count = Enum.count(monkeys)

    for monkey_number <- 0..count-1, reduce: monkeys do
      m -> inspect_items(m, monkey_number, manage?)
    end
  end

  defp inspect_items(monkeys, monkey_number, manage?) do
    monkey = Map.get(monkeys, monkey_number)

    inspects = Enum.count(monkey.items)
    {op, val} = monkey.operation

    {worry_management, management_value} =
      if manage? do
        {&rem/2, Enum.reduce(monkeys, 1, fn {_, %Monkey{test: test}}, product ->
          product * test
        end)}
      else
        {&div/2, 3}
      end

    monkeys = Enum.reduce(monkey.items, monkeys, fn item, m ->
      val = if val == "old", do: item, else: val
      worry = op.(item, val) |> worry_management.(management_value)
      receiving_number =
        if rem(worry, monkey.test) == 0, do: monkey.pass, else: monkey.fail

      receiving_monkey = Map.get(m, receiving_number)
      receiving_monkey = %{receiving_monkey | items: receiving_monkey.items ++ [worry]}

      Map.put(m, receiving_number, receiving_monkey)
    end)

    monkey = %{monkey | items: [], inspects: monkey.inspects + inspects}

    Map.put(monkeys, monkey_number, monkey)
  end

  defp build_monkeys(monkeys), do: build_monkeys(Map.new(), monkeys)
  defp build_monkeys(map, []), do: map
  defp build_monkeys(map, [monkey | monkeys]) do
    [number, starting_items, operation, test, pass, fail] = monkey

    number = number |> String.at(7) |> stoi()

    monkey = %Monkey{
      operation: format_operation(operation),
      test: test |> String.split(" ") |> List.last() |> stoi(),
      pass: pass |> String.split(" ") |> List.last() |> stoi(),
      fail: fail |> String.split(" ") |> List.last() |> stoi(),
      items: format_starting_items(starting_items)
    }

    map = Map.put(map, number, monkey)

    build_monkeys(map, monkeys)
  end

  defp format_operation(op) do
    cond  do
      String.contains?(op, "old * old")->
        {&Kernel.*/2, "old"}

      String.contains?(op, "*") ->
        op
        |> String.split(" * ")
        |> List.last()
        |> then(fn val -> {&Kernel.*/2, stoi(val)} end)

      true ->
        op
        |> String.split(" + ")
        |> List.last()
        |> then(fn val -> {&Kernel.+/2, stoi(val)} end)
    end
  end

  defp format_starting_items(items) do
    items
    |> String.split(": ")
    |> List.last()
    |> String.split(", ")
    |> Enum.map(&stoi/1)
  end
end
