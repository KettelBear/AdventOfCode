defmodule Interns do
  @moduledoc """
  Santa needs help figuring out which strings in his text file are naughty or
  nice.
  """

  @doc """
  How many strings are nice following these rules?
    - It contains at least three vowels (aeiou only), like aei, xazegov, or
      aeiouaeiouaeiou.
    - It contains at least one letter that appears twice in a row, like xx,
      abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
    - It does not contain the strings ab, cd, pq, or xy, even if they are
      part of one of the other requirements.
  """
  def part1(), do: parse_input("input.prod") |> rule_set_1()

  defp rule_set_1(words), do: rule_set_1(0, words)
  defp rule_set_1(count, []), do: count
  defp rule_set_1(count, [word | words]) do
    if nice?(word), do: rule_set_1(count + 1, words), else: rule_set_1(count, words)
  end

  defp nice?(word), do: three_vowels?(word) and double_letter?(word) and not bad_actor?(word)

  defp three_vowels?(word), do: String.graphemes(word) |> Enum.reduce_while(0, &count_vowel/2) > 2

  defp count_vowel(_char, 3), do: {:halt, 3}
  defp count_vowel("a", vowel_count), do: {:cont, vowel_count + 1}
  defp count_vowel("e", vowel_count), do: {:cont, vowel_count + 1}
  defp count_vowel("i", vowel_count), do: {:cont, vowel_count + 1}
  defp count_vowel("o", vowel_count), do: {:cont, vowel_count + 1}
  defp count_vowel("u", vowel_count), do: {:cont, vowel_count + 1}
  defp count_vowel(_char, vowel_count), do: {:cont, vowel_count}

  defp double_letter?(word) do
    word
    |> String.graphemes()
    |> Enum.reduce_while(false, &(if (&1 == &2), do: {:halt, :double}, else: {:cont, &1}))
    |> then(&(&1 == :double))
  end

  defp bad_actor?(word), do: String.contains?(word, ["ab", "cd", "pq", "xy"])

  @doc """
  How many strings are nice under these new rules?
    - It contains a pair of any two letters that appears at least twice in the
      string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not
      like aaa (aa, but it overlaps).
    - It contains at least one letter which repeats with exactly one letter
      between them, like xyx, abcdefeghi (efe), or even aaa.
  """
  def part2(), do: parse_input("input.prod") |> rule_set_2()

  defp rule_set_2(words), do: rule_set_2(0, words)
  defp rule_set_2(count, []), do: count
  defp rule_set_2(count, [word | words]) do
    if nice_2?(word), do: rule_set_2(count + 1, words), else: rule_set_2(count, words)
  end

  defp nice_2?(word), do: two_pair?(word) and letter_between?(word)

  defp two_pair?([_last_pair]), do: false
  defp two_pair?([pair, overlap | pairs]), do: if Enum.member?(pairs, pair), do: true, else: two_pair?([overlap | pairs])
  defp two_pair?(word), do: String.graphemes(word) |> Enum.chunk_every(2, 1, :discard) |> two_pair?()

  defp letter_between?([_a, _b]), do: false
  defp letter_between?([a, _b, a | _chars]), do: true
  defp letter_between?([_a | chars]), do: letter_between?(chars)
  defp letter_between?(word), do: String.graphemes(word) |> letter_between?()

  defp parse_input(in_file), do: File.read!(in_file) |> String.split(["\n", "\r\n"], trim: true)
end
