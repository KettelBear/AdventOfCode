defmodule ChitonTest do
  use ExUnit.Case
  doctest Chiton

  test "Dijkstras over single grid" do
    assert Chiton.part1() == 429
  end

  test "Dijkstras over 5x5 grid" do
    assert Chiton.part2() == 2844
  end
end
