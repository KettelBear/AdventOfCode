defmodule Pathing do
  @moduledoc """
  Advent of Code, Day 12, 2021
  """

  @doc """
  Part 1 asked to find the total number of paths through the cave system where
  each `small cave` (denoted by being lower case letters) could only be visited
  at most once.
  """
  def part1() do
    parse_input("input.prod")
    |> travel()
  end

  @doc """
  Part 2 asked to find the total number of paths through the cave system where
  exactly one `small cave` could be visited twice.
  """
  def part2() do
    parse_input("input.prod")
    |> traverse()
  end

  defp travel(graph), do: travel(graph["start"], graph, MapSet.new(["start"]), ["start"], 0)
  defp travel([], _graph, _seen, _path, count), do: count
  defp travel(["end" | caves], graph, seen, path, count) do
    travel(caves, graph, seen, path, count + 1)
  end
  defp travel([cave | caves], graph, seen, path, count) do
    count = 
      cond do
        cave in seen -> count
        lower?(cave) -> travel(graph[cave], graph, MapSet.put(seen, cave), [cave | path], count)
        true -> travel(graph[cave], graph, seen, [cave | path], count)
      end

    travel(caves, graph, seen, path, count)
  end

  defp traverse(graph), do: traverse(graph["start"], graph, %{"start" => 1}, ["start"], 0)
  defp traverse([], _graph, _seen, _path, count), do: count
  defp traverse(["end" | caves], graph, seen, path, count) do
    traverse(caves, graph, seen, path, count + 1)
  end
  defp traverse([cave | caves], graph, seen, path, count) do
    count = 
      cond do
        two_small?(seen) and cave in Map.keys(seen) ->
          count

        lower?(cave) -> 
          seen = Map.update(seen, cave, 1, fn v -> v + 1 end)
          traverse(graph[cave], graph, seen, [cave | path], count)

        true -> traverse(graph[cave], graph, seen, [cave | path], count)
      end

    traverse(caves, graph, seen, path, count)
  end

  def two_small?(caves_visited) do
    caves_visited
    |> Map.values()
    |> Enum.member?(2)
  end

  defp lower?(cave), do: ~r/^[a-z]+$/ |> Regex.match?(cave)
  
  defp parse_input(in_file) do
    in_file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn connection, acc ->
      [left, right] = String.split(connection, "-")

      # This condition just prevents nodes from pointing to `start`
      # and prevents `end` from pointing anywhere
      cond do
        left == "start" -> Map.update(acc, "start", [right], &[right | &1])
        right == "start" -> Map.update(acc, "start", [left], &[left | &1])
        left == "end" -> Map.update(acc, right, ["end"], &["end" | &1])
        right == "end" -> Map.update(acc, left, ["end"], &["end" | &1])
        true ->
          Map.update(acc, left, [right], &[right | &1])
          |> Map.update(right, [left], &[left | &1])
      end
    end)
  end
end
