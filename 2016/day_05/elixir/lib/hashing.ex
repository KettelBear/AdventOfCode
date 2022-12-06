defmodule Hashing do
  @moduledoc """
  You are faced with a security door designed by Easter Bunny engineers that
  seem to have acquired most of their security knowledge by watching hacking
  movies.
  The eight-character password for the door is generated one character at a time
  by finding the MD5 hash of some Door ID (your puzzle input) and an increasing
  integer index (starting with 0).
  A hash indicates the next character in the password if its hexadecimal
  representation starts with five zeroes. If it does, the sixth character in the
  hash is the next character of the password.
  """

  @door_id "reyedfim"

  @doc """
  Given the actual Door ID, what is the password?
  """
  def part1(), do: find_pass()

  defp find_pass() do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while([], &calculate_pass/2)
  end

  defp calculate_pass(_, pass_chars) when length(pass_chars) > 7 do
    {:halt, pass_chars |> Enum.reverse() |> Enum.join()}
  end

  defp calculate_pass(suffix, pass_chars) do
    suffix
    |> prepend_door_id()
    |> md5_base16()
    |> case do
      "00000" <> rest -> [String.at(rest, 0) | pass_chars]
      _ -> pass_chars
    end
    |> then(fn chars -> {:cont, chars} end)
  end

  @doc """
  As the door slides open, you are presented with a second door that uses a
  slightly more inspired security mechanism. Clearly unimpressed by the last
  version (in what movie is the password decrypted in order?!), the Easter Bunny
  engineers have worked out a better solution.
  Instead of simply filling in the password from left to right, the hash now
  also indicates the position within the password to fill. You still look for
  hashes that begin with five zeroes; however, now, the sixth character
  represents the position (0-7), and the seventh character is the character to
  put in that position.
  A hash result of 000001f means that f is the second character in the password.
  Use only the **first result** for each position, and ignore invalid positions.
  Given the actual Door ID and this new method, what is the password?
  """
  def part2(), do: find_better_pass()

  defp find_better_pass() do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(%{}, &deduce_pass/2)
  end

  defp deduce_pass(suffix, pass_char_map) do
    if Map.keys(pass_char_map) |> length() > 7 do
      # Thankfully, maps are not ordered by entry.
      {:halt, pass_char_map |> Map.values() |> Enum.join()}
    else
      suffix
      |> prepend_door_id()
      |> md5_base16()
      |> handle_hash(pass_char_map)
      |> then(fn pass_map -> {:cont, pass_map} end)
    end
  end

  defp handle_hash("00000" <> rest, pass_map) do
    [p, c | _] = String.graphemes(rest)

    case Integer.parse(p) do
      {position, _} ->
        if position > 7, do: pass_map, else: Map.put_new(pass_map, position, c)

      :error ->
        pass_map
    end
  end

  defp handle_hash(_, pass_map), do: pass_map

  defp prepend_door_id(suffix), do: "#{@door_id}#{suffix}"

  defp md5_base16(str), do: :crypto.hash(:md5, str) |> Base.encode16()
end
