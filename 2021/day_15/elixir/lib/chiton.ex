defmodule Chiton do
  def part1() do
    parse_input("input.prod")
    |> list_to_map()
    |> get_destination()
    |> dijkstras()
    |> IO.inspect()
  end

  def part2() do
    parse_input("input.prod")
    |> expand_grid()
    |> list_to_map()
    |> get_destination()
    |> dijkstras()
    |> IO.inspect()
  end

  defp get_destination(map) do
    destination =
      map
      |> Map.keys()
      |> Enum.max()

    {map, destination}
  end

  defp dijkstras({map, destination}), do: dijkstras([{{0,0}, 0}], map, destination, Map.new(Enum.map(Map.keys(map), &{&1, Infinity})))
  defp dijkstras([{node, cost} | remaining], map, destination, costs) do
    if node == destination do
      cost
    else
      neighbors = get_neighbors(map, node) |> Map.keys()

      {q, c} =
        Enum.reduce(neighbors, {remaining, costs}, fn point, {queue_acc, cost_acc} = acc ->
          new_cost = cost + Map.get(map, point)

          if new_cost < Map.get(costs, point) do
            {[{point, new_cost} | queue_acc], Map.put(cost_acc, point, new_cost)}
          else
            acc
          end
        end)

      dijkstras(Enum.sort_by(q, fn {{x, y}, cost} -> {cost, x, y} end), map, destination, c)
    end
  end

  defp get_neighbors(map, {x, y}) do
    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.reduce(%{}, fn {dx, dy}, acc ->
      point = {x + dx, y + dy}
      value = Map.get(map, point)

      if value, do: Map.put(acc, point, value), else: acc
    end)
  end

  defp list_to_map(list) do
    Enum.with_index(list)
    |> Enum.reduce(%{}, fn {row, x}, acc ->
      Enum.with_index(row)
      |> Enum.reduce(acc, fn {value, y}, row_acc ->
        Map.put(row_acc, {x, y}, value)
      end)
    end)
  end

  defp expand_grid(grid) do
    for x <- 0..4, y <- 0..4 do
      x + y
    end
    |> Enum.chunk_every(5)
    |> Enum.flat_map(fn line ->
      Enum.reduce(line, [], fn level, acc ->
        new_values(grid, level)
        |> Enum.with_index()
        |> Enum.map(fn {x, index} ->
          Enum.at(acc, index, []) ++ x
        end)
      end)
    end)
  end

  defp new_values(grid, level) do
    cycle = Stream.cycle(1..9)

    grid
    |> Enum.map(fn line ->
      Enum.map(line, fn x ->
        Enum.at(cycle, x + level - 1)
      end)
    end)
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split("\r\n", time: true)
    |> Enum.map(fn value -> value |> String.to_integer() |> Integer.digits() end)
  end
end
