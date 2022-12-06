defmodule InternsTest do
  use ExUnit.Case
  doctest Interns

  test "How many strings are nice?" do
    assert Interns.part1() == 258
  end

  test "How many strings are nice under these new rules?" do
    assert Interns.part2() == 53
  end
end
