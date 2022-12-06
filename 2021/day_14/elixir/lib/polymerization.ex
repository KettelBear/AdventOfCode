defmodule Polymerization do
  def part1() do
    solve(1..10)
  end

  def part2() do
    solve(1..40)
  end

  defp solve(iterations) do
    {template, rules} = parse_input("input.prod")

    char_frequencies =
      template
      |> String.graphemes()
      |> Enum.frequencies()

    pair_frequencies =
      template
      |> String.graphemes()
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.frequencies()
      |> Enum.map(fn {[c1, c2], freq} -> {c1 <> c2, freq} end)

    {min, max} =
      Enum.reduce(iterations, {char_frequencies, pair_frequencies}, fn _step, {char_freq, pair_freq} ->
        step(rules, char_freq, pair_freq |> Enum.to_list(), %{})
      end)
      |> elem(0)
      |> Map.values()
      |> Enum.min_max_by(fn value -> value end)

    max - min
  end

  defp step(_rules, char_frequencies, [], pair_step), do: {char_frequencies, pair_step}
  defp step(rules, char_frequencies, [{pair, freq} | pairs], pair_step) do
    {char_freq, pair_step} =
      cond do
        Map.has_key?(rules, pair) ->
          letter = rules[pair]
          char_frequencies = Map.update(char_frequencies, letter, freq, fn value -> value + freq end)
          pair_step =
            pair_step
            |> Map.update(String.first(pair) <> letter, freq, fn value -> value + freq end)
            |> Map.update(letter <> String.last(pair), freq, fn value -> value + freq end)
          {char_frequencies, pair_step}

        true ->
          {char_frequencies, pair_step}
      end
    step(rules, char_freq, pairs, pair_step)
  end

  defp parse_input(in_file) do
    [polymer, rules] =
      File.read!(in_file)
      |> String.split("\r\n\r\n", trim: true)

    rules =
      String.split(rules, "\r\n", trim: true)
      |> Enum.map(fn rule ->
        [input, output] =
          rule
          |> String.split(" -> ")

        {input, output}
      end)
      |> Enum.into(%{})

    {polymer, rules}
  end
end
