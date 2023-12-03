defmodule FireHazard do
  @moduledoc """
  Because your neighbors keep defeating you in the holiday house decorating
  contest year after year, you've decided to deploy one million lights in a
  1000x1000 grid.

  Furthermore, because you've been especially nice this year, Santa has mailed
  you instructions on how to display the ideal lighting configuration.
  """

  def part1() do
    parse_input("input.prod")
    |> instruction()
    |> Enum.count(fn {_point, on?} -> on? end)
  end

  defp instruction(instr_set), do: instruction(%{}, instr_set)
  defp instruction(grid, []), do: grid
  defp instruction(grid, [{instr, xs, ys} | remaining]) do
    Enum.reduce(xs, grid, fn x, acc ->
      Enum.reduce(ys, acc, fn y, a ->
        case instr do
          :on -> Map.put(a, {x, y}, true)
          :off -> Map.put(a, {x, y}, false)
          :toggle -> Map.update(a, {x, y}, true, fn v -> not v end)
        end
      end)
    end)
    |> instruction(remaining)
  end

  def part2() do
    parse_input("input.prod")
    |> brightness()
    |> bright_level()
  end

  defp brightness(instr_set), do: brightness(%{}, instr_set)
  defp brightness(grid, []), do: grid
  defp brightness(grid, [{instr, xs, ys} | remaining]) do
    Enum.reduce(xs, grid, fn x, acc ->
      Enum.reduce(ys, acc, fn y, a ->
        case instr do
          :on -> Map.update(a, {x, y}, 1, fn b -> b + 1 end)
          :off -> Map.update(a, {x, y}, 0, fn b -> if b > 0, do: b - 1, else: 0 end)
          :toggle -> Map.update(a, {x, y}, 2, fn b -> b + 2 end)
        end
      end)
    end)
    |> brightness(remaining)
  end

  defp bright_level(grid) do
    grid
    |> Enum.reduce(0, fn {_point, brightness}, acc -> acc + brightness end)
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split(["\n", "\r\n"], trim: true)
    |> Enum.map(fn instruction ->
      instruction
      |> String.split(" ")
      |> parse_instruction()
    end)
  end

  defp parse_instruction(["turn", "off", cor, _through, ner]), do: parse_instruction(:off, cor, ner)
  defp parse_instruction(["turn", "on", cor, _through, ner]), do: parse_instruction(:on, cor, ner)
  defp parse_instruction(["toggle", cor, _through, ner]), do: parse_instruction(:toggle, cor, ner)
  defp parse_instruction(instr, cor, ner) do
    [x1, y1] = split_coordinates(cor)
    [x2, y2] = split_coordinates(ner)

    {instr, x1..x2, y1..y2}
  end

  defp split_coordinates(coord), do: coord |> String.split(",") |> Enum.map(&String.to_integer/1)
end
