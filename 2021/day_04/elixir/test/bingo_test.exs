defmodule BingoTest do
  use ExUnit.Case
  doctest Bingo

  test "Calculates the first winning board score" do
    assert Bingo.part1() == 10374
  end

  test "Calculates the last winning board score" do
    assert Bingo.part2() == 24742
  end
end
