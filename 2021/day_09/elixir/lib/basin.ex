defmodule Basin do
  def part1() do
    grid = parse_input("input.prod")

    grid
    |> Enum.filter(&local_minimum(grid, &1))
    |> Enum.reduce(0, fn {_, value}, acc -> acc + value + 1 end)
  end

  def part2() do
    grid = parse_input("input.prod")

    Enum.filter(grid, &local_minimum(grid, &1))
    |> Enum.map(fn {point, _} ->
      point
      |> basin(grid)
      |> MapSet.size()
    end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  defp basin(point, grid) do
    basin(MapSet.new(), point, grid)
  end
  defp basin(set, {row, col} = point, grid) do
    if grid[point] in [9, nil] or point in set do
      set
    else
      set
      |> MapSet.put(point)
      |> basin({row - 1, col}, grid)
      |> basin({row + 1, col}, grid)
      |> basin({row, col - 1}, grid)
      |> basin({row, col + 1}, grid)
    end
  end

  defp local_minimum(grid, {{row, col}, value}) do
      up = grid[{row + 1, col}]
      down = grid[{row - 1, col}]
      right = grid[{row, col + 1}]
      left = grid[{row, col - 1}]

      value < up and value < down and value < right and value < left
  end

  defp parse_input(in_file) do
    for {line, row} <- Enum.with_index(String.split(File.read!(in_file), "\n", trim: true)),
        {number, col} <- Enum.with_index(String.to_charlist(line)),
        into: %{} do
          {{row, col}, number - ?0}
    end
  end
end
