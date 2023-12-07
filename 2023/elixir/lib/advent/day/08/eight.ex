defmodule Advent.Day.Eight do
  @moduledoc """
  In the examples you'll see deadends, for example: XXX = (XXX, XXX).
  This code does not handle that case anymore. When I initially wrote
  it, that scenario was handled, however, running the tests pass
  without handling that case. So, I moved that out to make the code
  cleaner to read.
  """

  import Advent.Utility

  @doc """
  Starting at AAA, follow the left/right instructions. How many steps are required to reach ZZZ?
  """
  def part1 do
    {steps, graph} = parse_day8_input!("#{__DIR__}/input.two.test")

    traverse("AAA", steps, 0, steps, graph)
  end

  defp traverse("ZZZ", _steps, count, _step_list, _graph), do: count
  defp traverse(curr_node, [], count, step_list, graph) do
    traverse(curr_node, step_list, count, step_list, graph)
  end
  defp traverse(curr_node, [direction | steps], count, step_list, graph) do
    {left, right} = Map.get(graph, curr_node)

    case direction do
      "L" -> traverse(left, steps, count+1, step_list, graph)
      "R" -> traverse(right, steps, count+1, step_list, graph)
    end
  end

  @doc """
  Simultaneously start on every node that ends with A. How many steps does
  it take before you're only on nodes that end with Z?
  """
  def part2 do
    {steps, graph} = parse_day8_input!("#{__DIR__}/input.two.test")

    starts = Map.keys(graph) |> Enum.filter(&String.ends_with?(&1, "A"))

    starts
    |> Enum.reduce([], fn starting_key, acc ->
      [walk(starting_key, steps, 0, steps, graph) | acc]
    end)
    |> lcm()
  end

  defp walk(curr_node, [], count, steps, graph), do: walk(curr_node, steps, count, steps, graph)
  defp walk(curr_node, [direction | rest], count, steps, graph) do
    if String.ends_with?(curr_node, "Z") do
      count
    else
      {left, right} = Map.get(graph, curr_node)

      case direction do
        "L" -> walk(left, rest, count+1, steps, graph)
        "R" -> walk(right, rest, count+1, steps, graph)
      end
    end
  end

  # The LCM of [a, b, c, ..., z] == LCM(a, b) |> LCM(c) |> ... |> LCM(z)
  defp lcm([last]), do: last
  defp lcm([one, two | rest]) do
    lcm([div((one * two), Integer.gcd(one, two)) | rest])
  end
end
