defmodule Security do
  @moduledoc """
  Finally, you come across an information kiosk with a list of rooms. Of course,
  the list is encrypted and full of decoy data, but the instructions to decode
  the list are barely hidden nearby. Better remove the decoy data first.
  Each room consists of an encrypted name (lowercase letters separated by
  dashes) followed by a dash, a sector ID, and a checksum in square brackets.
  A room is real (not a decoy) if the checksum is the five most common letters
  in the encrypted name, in order, with ties broken by alphabetization. For
  example:
    - aaaaa-bbb-z-y-x-123[abxyz] is a real room because the most common letters
      are a (5), b (3), and then a tie between x, y, and z, which are listed
      alphabetically.
    - a-b-c-d-e-f-g-h-987[abcde] is a real room because although the letters are
      all tied (1 of each), the first five are listed alphabetically.
    - not-a-real-room-404[oarel] is a real room.
    - totally-real-room-200[decoy] is not.
  Of the real rooms from the list above, the sum of their sector IDs is 1514.
  """

  @doc """
  What is the sum of the sector IDs of the real rooms?
  """
  def part1() do
    parse_input("input.prod")
    |> prepare_rooms()
    |> get_valid_room_ids()
    |> Enum.sum()
  end

  defp get_valid_room_ids(room_list) do
    Enum.reduce(room_list, [], &evaluate_room/2)
  end

  defp evaluate_room({code, frequency_list}, acc) do
    [digit, key] = code |> String.slice(0..-2) |> String.split("[")

    if valid?(frequency_list, String.graphemes(key)) do
      [String.to_integer(digit) | acc]
    else
      acc
    end
  end

  defp valid?([], []), do: true
  defp valid?([k | rest], [char | remaining]) do
    if char == k, do: valid?(rest, remaining), else: false
  end
  defp valid?(_, _), do: false

  defp prepare_rooms(room_list), do: Enum.map(room_list, &count_characters/1)

  defp count_characters(room_name) do
    room_name
    |> String.split("-")
    |> Enum.reduce_while(%{}, &letter_counts/2)
    |> get_top_five()
  end

  defp letter_counts(word, frequencies) do
    if Regex.match?(~r/[\d]+\[[a-z]{5}\]$/, word) do
      {:halt, {word, frequencies}}
    else
      letters = word |> String.graphemes() |> Enum.frequencies()
      freq = Map.merge(frequencies, letters, fn _k, v1, v2 -> v1 + v2 end)

      {:cont, freq}
    end
  end

  defp get_top_five({code, frequencies}) do
    frequencies
    |> Map.to_list()
    |> Enum.sort(&sort_most_common/2)
    |> Enum.take(5)
    |> Enum.map(fn {k, _} -> k end)
    |> then(fn top_five -> {code, top_five} end)
  end

  defp sort_most_common({k1, v1}, {k2, v2}) do
    cond do
      v1 > v2 -> true
      v2 == v1 -> k1 < k2
      true -> false
    end
  end

  @doc """
  With all the decoy data out of the way, it's time to decrypt this list and get
  moving.
  The room names are encrypted by a state-of-the-art shift cipher, which is
  nearly unbreakable without the right software. However, the information kiosk
  designers at Easter Bunny HQ were not expecting to deal with a master
  cryptographer like yourself.
  To decrypt a room name, rotate each letter forward through the alphabet a
  number of times equal to the room's sector ID. A becomes B, B becomes C, Z
  becomes A, and so on. Dashes become spaces.
  For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.
  What is the sector ID of the room where North Pole objects are stored?
  """
  def part2(), do: parse_input("input.prod") |> find_id()

  defp find_id(room_list), do: Enum.find_value(room_list, &check_room/1)

  defp check_room(room) do
    code = parse_code(room)

    if room |> rotate(code) |> String.contains?("northpole"), do: code
  end

  defp rotate(room_name, rotation) do
    caesar_shift = rem(rotation, 26)

    room_name
    |> String.to_charlist()
    |> Enum.map(fn c -> rem((c - ?a + caesar_shift), 26) + ?a end)
    |> to_string()
  end

  defp parse_code(room_name) do
    room_name
    |> String.split("-")
    |> List.last()
    |> String.split("[")
    |> hd()
    |> String.to_integer()
  end

  defp parse_input(file) do
    file
    |> File.read!()
    |> String.split(["\n", "\r\n"], trim: true)
  end
end
