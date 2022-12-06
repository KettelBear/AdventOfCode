defmodule Syntax do
  @p1_point_map %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
  @p2_point_map %{")" => 1, "]" => 2, "}" => 3, ">" => 4}
  @closer_lookup %{"(" => ")", "[" => "]", "{" => "}", "<" => ">"}

  def part1() do
    parse_input("input.prod")
    |> collect_bad_closers()
    |> sum_syntax_error()
  end

  def part2() do
    parse_input("input.prod")
    |> collect_line_finishers()
    |> auto_complete_scores()
    |> Enum.sort()
    |> get_median_score()
  end

  defp get_median_score(scores) do
    scores
    |> Enum.at(length(scores) |> div(2))
  end

  defp auto_complete_scores(lines), do: auto_complete_scores([], lines)
  defp auto_complete_scores(scores, []), do: scores
  defp auto_complete_scores(scores, [line | lines]) do
    line_score = Enum.reduce(line, 0, fn char, acc -> acc * 5 + @p2_point_map[char] end)

    auto_complete_scores([line_score | scores], lines)
  end

  defp collect_line_finishers(lines) do
    lines
    |> Enum.reduce([], fn line, acc ->
      {stack, bad_char?} =
        line
        |> Enum.reduce_while({[], false}, fn char, {closer_stack, _bad_char} ->
          cond do
            char in ["(", "[", "{", "<"] -> {:cont, {[@closer_lookup[char] | closer_stack], false}}
            char == hd(closer_stack) -> {:cont, {tl(closer_stack), false}}
            true -> {:halt, {closer_stack, true}}
          end
        end)

      if not bad_char?, do: [stack | acc], else: acc
    end)
  end

  defp sum_syntax_error(bad_char_occurences) do
    bad_char_occurences
    |> Enum.reduce(0, fn {char, occurances}, sum ->
      sum + occurances * @p1_point_map[char]
    end)
  end

  defp collect_bad_closers(lines) do
    bad_closers = %{")" => 0, "]" => 0, "}" => 0, ">" => 0}
    lines
    |> Enum.reduce(bad_closers, fn line, bad_close ->
      {_stack, bad_char} =
        line
        |> Enum.reduce_while({[], ""}, fn char, {closer_stack, _bad_char} ->
          cond do
            char in ["(", "[", "{", "<"] -> {:cont, {[@closer_lookup[char] | closer_stack], ""}}
            char == hd(closer_stack) -> {:cont, {tl(closer_stack), ""}}
            true -> {:halt, {closer_stack, char}}
          end
        end)

      Map.update(bad_close, bad_char, 1, fn val -> val + 1 end)
    end)
    |> Map.delete("")
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end
