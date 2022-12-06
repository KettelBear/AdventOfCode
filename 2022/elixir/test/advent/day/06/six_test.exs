defmodule Advent.Day.SixTest do
  use ExUnit.Case

  alias Advent.Day.Six

  describe "Day 6 code" do
    test "solves part 1" do
      assert Six.part1() == 1953
    end

    test "solves part 2" do
      assert Six.part2() == 2301
    end
  end
end
