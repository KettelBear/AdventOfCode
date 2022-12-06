defmodule HashingTest do
  use ExUnit.Case
  doctest Hashing

  test "greets the world" do
    assert Hashing.part1() == "F97C354D"
  end

  test "greets the earth" do
    assert Hashing.part2() == "863DDE27"
  end
end
