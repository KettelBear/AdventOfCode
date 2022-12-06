defmodule StockingStufferTest do
  use ExUnit.Case
  doctest StockingStuffer

  test "Start with at least five zeroes" do
    assert StockingStuffer.part1() == 346386
  end

  test "Now find one that starts with six zeroes" do
    assert StockingStuffer.part2() == 9958218
  end
end
