defmodule Taxicab do
  @moduledoc """
  You're airdropped near Easter Bunny Headquarters in a city somewhere.
  "Near", unfortunately, is as close as you can get - the instructions on the
  Easter Bunny Recruiting Document the Elves intercepted start here, and
  nobody had time to work them out further.

  The Document indicates that you should start at the given coordinates
  (where you just landed) and face North. Then, follow the provided sequence:
  either turn left (L) or right (R) 90 degrees, then walk forward the given
  number of blocks, ending at a new intersection.
  """

  @doc """
  There's no time to follow such ridiculous instructions on foot, though, so
  you take a moment and work out the destination. Given that you can only
  walk on the street grid of the city, how far is the shortest path to the
  destination?
  """
  def part1(), do: parse_input("input.prod") |> follow()

  @doc """
  Then, you notice the instructions continue on the back of the Recruiting
  Document. Easter Bunny HQ is actually at the first location you visit twice.
  How many blocks away is the first location you visit twice?
  """
  def part2(), do: parse_input("input.prod") |> find_revisit()

  defp move({x, y}, facing, blocks) do
    case facing do
      0 -> {x, y + blocks}
      1 -> {x + blocks, y}
      2 -> {x, y - blocks}
      3 -> {x - blocks, y}
    end
  end

  defp find_revisit({x, y}), do: calc_dist(x, y)
  defp find_revisit(instr), do: find_revisit({0, 0}, MapSet.new([{0,0}]), 0, instr)
  defp find_revisit({x, y} = pos, set, facing, [{turn, blocks} | directions]) do
    facing = new_face(facing, turn)
    last_pos = move(pos, facing, blocks)

    case facing do
      0 -> Enum.reduce_while(y+1..(y+blocks), set, fn dy, acc ->
          if MapSet.member?(acc, {x, dy}) do
            {:halt, {x,dy}}
          else
            {:cont, MapSet.put(acc,{x,dy})}
          end
      end)
      1 -> Enum.reduce_while(x+1..(x+blocks), set, fn dx, acc ->
          if MapSet.member?(acc,{dx, y}) do
            {:halt, {dx, y}}
          else
            {:cont, MapSet.put(acc,{dx, y})}
          end
      end)
      2 -> Enum.reduce_while(y-1..(y-blocks), set, fn dy, acc ->
          if MapSet.member?(acc, {x, dy}) do
            {:halt, {x,dy}}
          else
            {:cont, MapSet.put(acc,{x,dy})}
          end
      end)
      3 -> Enum.reduce_while(x-1..(x-blocks), set, fn dx, acc ->
          if MapSet.member?(acc, {dx, y}) do
            {:halt, {dx,y}}
          else
            {:cont, MapSet.put(acc,{dx,y})}
          end
      end)
    end
    |> case do
      {_, _} = location -> find_revisit(location)
      acc -> find_revisit(last_pos, acc, facing, directions)
    end
  end

  defp calc_dist(x, y), do: abs(x) + abs(y)

  defp follow(set), do: follow({0,0}, 0, set)
  defp follow({x, y}, _, []), do: calc_dist(x, y)
  defp follow({x, y}, facing, [{turn, blocks} | directions]) do
    facing = new_face(facing, turn)

    case facing do
      0 -> follow({x, y + blocks}, facing, directions)
      1 -> follow({x + blocks, y}, facing, directions)
      2 -> follow({x, y - blocks}, facing, directions)
      3 -> follow({x - blocks, y}, facing, directions)
    end
  end

  defp new_face(facing, turn) do
    cond do
      turn == "R" and facing == 3 -> 0
      turn == "L" and facing == 0 -> 3
      turn == "R" -> facing + 1
      true -> facing - 1
    end
  end

  defp parse_input(path) do
    File.read!(path)
    |> String.trim()
    |> String.split(", ")
    |> Enum.map(fn <<turn::binary-size(1)>> <> blocks ->
      {turn, String.to_integer(String.trim(blocks))}
    end)
  end
end
