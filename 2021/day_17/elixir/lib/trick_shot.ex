defmodule TrickShot do
  def part1() do
    parse_input("input.prod")
    |> calc_peak()
  end

  def part2() do
    target = parse_input("input.prod")

    find_vertical_hits(target)
    |> find_horizontal_pairs(target)
    |> Enum.reduce(0, fn {_v, h_pairs}, acc ->
      acc + Enum.count(h_pairs)
    end)
  end

  defp find_vertical_hits(target_zone) do
    {lowest, highest} = target_zone["y"]

    Enum.reduce(lowest..abs(lowest) - 1, [], fn init_vel, target_hits ->
      hits =
        Stream.iterate(1, &(&1 + 1))
        |> Enum.reduce_while([], fn time, acc ->
          dist = calc_vert_pos(time, init_vel)
          cond do
            dist > highest -> {:cont, acc}
            dist >= lowest and dist <= highest -> {:cont, [{init_vel, time} | acc]}
            true -> {:halt, acc}
          end
        end)

      hits ++ target_hits
    end)
  end

  defp calc_peak(%{"y" => {lowest, _highest}}) do
    # Can use the sum of numbers, because, just think about it.
    sum_of_nums(abs(lowest + 1))
  end

  defp find_horizontal_pairs(verticals, target), do: find_horizontal_pairs(target, verticals, Map.new())
  defp find_horizontal_pairs(_target, [], map), do: map
  defp find_horizontal_pairs(target, [{vert_vel, _time} | verticals], map) do
    {h_low, h_high} = target["x"]
    {v_low, v_high} = target["y"]
    horizontals =
      Enum.reduce(1..h_high, [], fn horiz, acc ->
        hit? =
          Stream.iterate(1, &(&1 + 1))
          |> Enum.reduce_while(false, fn time, _acc ->
            v = calc_vert_pos(time, vert_vel)
            h = if time > horiz, do: sum_of_nums(horiz), else: calc_horiz_pos(time, horiz)
            cond do
              v >= v_low and v <= v_high and h >= h_low and h <= h_high ->
                {:halt, true}

              v > v_high and h >= h_low and h <= h_high ->
                {:cont, false}

              time <= horiz and h < h_low and v > v_low ->
                {:cont, false}

              time > horiz and h < h_low ->
                {:halt, false}

              true -> {:halt, false}
            end
          end)

        if hit?, do: [horiz | acc], else: acc
      end)

    find_horizontal_pairs(target, verticals, Map.put(map, vert_vel, horizontals))
  end

  defp calc_horiz_pos(1, horiz), do: horiz
  defp calc_horiz_pos(time, horiz), do: horiz + calc_horiz_pos(time - 1, horiz - 1)

  defp calc_vert_pos(time, vert), do: calc_vert_pos(time, vert, 0)
  defp calc_vert_pos(1, vert, modifier), do: vert - modifier
  defp calc_vert_pos(time, vert, modifier), do: vert - modifier + calc_vert_pos(time - 1, vert, modifier + 1)

  defp sum_of_nums(n), do: (n * (n + 1)) / 2

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split([",", " "], trim: true)
    |> Enum.filter(fn str -> String.contains?(str, "=") end)
    |> Enum.map(fn range ->
      [axis, bottom, top] = String.split(range, ["=", ".."])
      {axis, {String.to_integer(bottom), String.to_integer(top)}}
    end)
    |> Enum.into(%{})
  end
end
