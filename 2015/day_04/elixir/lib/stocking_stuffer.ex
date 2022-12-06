defmodule StockingStuffer do
  @moduledoc """
  Santa needs help mining some AdventCoins (very similar to bitcoins) to use as
  gifts for all the economically forward-thinking little girls and boys.
  To do this, he needs to find MD5 hashes which, in hexadecimal, start with at
  least five zeroes. The input to the MD5 hash is some secret key (your puzzle
  input, given below) followed by a number in decimal. To mine AdventCoins, you
  must find Santa the lowest positive number (no leading zeroes: 1, 2, 3, ...)
  that produces such a hash.
  """
  @input "iwrupvqb"

  @doc """
  Start with five zeroes
  """
  def part1(), do: find_hash("00000")

  @doc """
  Starts with six zeroes
  """
  def part2(), do: find_hash("000000")

  defp find_hash(prefix) do
    Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(0, &(if found?(prefix, &1), do: {:halt, &1}, else: {:cont, &2}))
  end

  defp found?(prefix, suffix), do: md5_base16("#{@input}#{suffix}") |> String.starts_with?(prefix)

  defp md5_base16(str), do: :crypto.hash(:md5, str) |> Base.encode16()
end
