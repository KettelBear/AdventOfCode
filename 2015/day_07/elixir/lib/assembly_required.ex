defmodule AssemblyRequired do
  @moduledoc """
  This year, Santa brought little Bobby Tables a set of wires and bitwise logic
  gates! Unfortunately, little Bobby is a little under the recommended age
  range, and he needs help assembling the circuit.
  Each wire has an identifier (some lowercase letters) and can carry a 16-bit
  signal (a number from 0 to 65535). A signal is provided to each wire by a
  gate, another wire, or some specific value. Each wire can only get a signal
  from one source, but can provide its signal to multiple destinations. A gate
  provides no signal until all of its inputs have a signal.
  The included instructions booklet describes how to connect the parts
  together: x AND y -> z means to connect wires x and y to an AND gate, and
  then connect its output to wire z.
  """
  import Bitwise

  defdelegate stoi(num_as_str), to: String, as: :to_integer

  @doc """
  In little Bobby's kit's instructions booklet (provided as your puzzle input),
  what signal is ultimately provided to wire a?
  """
  def part1(), do: do_work("input.prod")

  @doc """
  Now, take the signal you got on wire a, override wire b to that signal, and
  reset the other wires (including wire a). What new signal is ultimately
  provided to wire a?
  """
  def part2(), do: do_work("input2.prod")

  defp do_work(in_file), do: parse_input(in_file) |> follow_path("a", Map.new()) |> Map.get("a")

  defp follow_path(circuit, wire, cache) do
    case Map.get(cache, wire) do
      val when not is_nil(val) ->
        cache

      nil ->
        case Map.get(circuit, wire) do
          v when is_integer(v) ->
            Map.put(cache, wire, v)

          {:wire, w} ->
            cache = follow_path(circuit, w, cache)
            Map.put(cache, wire, Map.get(cache, w))

          {:not, w} when is_integer(w) ->
            Map.put(cache, wire, ~~~w)

          {:not, w} ->
            cache = follow_path(circuit, w, cache)
            Map.put(cache, wire, ~~~Map.get(cache, w))

          {func, one, two} ->
            cond do
              is_integer(one) and is_integer(two) ->
                Map.put(cache, wire, func.(one, two))

              is_integer(one) ->
                cache = follow_path(circuit, two, cache)
                Map.put(cache, wire, func.(one, Map.get(cache, two)))

              is_integer(two) ->
                cache = follow_path(circuit, one, cache)
                Map.put(cache, wire, func.(Map.get(cache, one), two))

              true ->
                cache = follow_path(circuit, one, cache)
                cache = follow_path(circuit, two, cache)
                Map.put(cache, wire, func.(Map.get(cache, one), Map.get(cache, two)))
            end
        end
    end
  end

  defp parse_input(in_file) do
    File.read!(in_file)
    |> String.split(["\n", "\r\n"], trim: true)
    |> Enum.map(&String.split(&1, " -> "))
    |> Enum.map(fn [value, wire] ->
      value = String.split(value, " ")
      case value do
        ["1", "AND", w] -> {wire, {&Bitwise.&&&/2, 1, w}}
        [w1, "AND", w2] -> {wire, {&Bitwise.&&&/2, w1, w2}}
        [w1, "OR", w2] -> {wire, {&Bitwise.|||/2, w1, w2}}
        [w1, "LSHIFT", w2] -> {wire, {&Bitwise.<<</2, w1, stoi(w2)}}
        [w1, "RSHIFT", w2] -> {wire, {&Bitwise.>>>/2, w1, stoi(w2)}}
        ["NOT", w] -> {wire, {:not, w}}
        [w] ->
          try do
            {wire, stoi(w)}
          rescue
            ArgumentError -> {wire, {:wire, w}}
          end
      end
    end)
    |> Enum.into(%{})
  end
end
