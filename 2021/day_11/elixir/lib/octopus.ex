defmodule Octopus do
  def part1() do
    o_map = parse_input("input.prod")

    Enum.map_reduce(1..100, o_map, fn _, o_map ->
      {o_map, flashes} = step(o_map)
      {flashes, o_map}
    end)
    |> elem(0)
    |> Enum.sum()
  end

  def part2() do
    o_map = parse_input("input.prod")

    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(o_map, fn step, o_map ->
      case step(o_map) do
        {o_map, flashes} when map_size(o_map) == flashes -> {:halt, step}
        {o_map, _flashes} -> {:cont, o_map}
      end
    end)
  end

  defp step(o_map), do: flash(Map.keys(o_map), o_map, MapSet.new())

  defp flash([], o_map, flashed), do: {o_map, MapSet.size(flashed)}
  defp flash([{row, col} = key | keys], o_map, flashed) do
    energy = o_map[key]

    cond do
      is_nil(energy) or key in flashed ->
        flash(keys, o_map, flashed)

      o_map[key] >= 9 ->
        keys = [
          {row - 1, col - 1},
          {row - 1, col},
          {row - 1, col + 1},
          {row, col - 1},
          {row, col + 1},
          {row + 1, col - 1},
          {row + 1, col},
          {row + 1, col + 1}
          | keys
        ]
        flash(keys, Map.put(o_map, key, 0), MapSet.put(flashed, key))

      true ->
        flash(keys, Map.put(o_map, key, energy + 1), flashed)
    end
  end

  defp parse_input(in_file) do
    for {line, row} <- Enum.with_index(String.split(File.read!(in_file), "\r\n", trim: true)),
        {number, col} <- Enum.with_index(String.to_charlist(line)),
        into: %{} do
          {{row, col}, number - ?0}
    end
  end
end
