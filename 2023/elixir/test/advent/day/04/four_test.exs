defmodule Advent.Day.FourTest do
  use ExUnit.Case

  alias Advent.Day.Four

  describe "Day 4 code" do
    test "solves part 1" do
      assert Four.part1() == 21_138
    end

    test "solves part 2" do
      assert Four.part2() == 7_185_540
    end
  end
end
