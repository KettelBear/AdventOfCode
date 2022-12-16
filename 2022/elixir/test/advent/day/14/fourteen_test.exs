defmodule Advent.Day.FourteenTest do
  use ExUnit.Case

  alias Advent.Day.Fourteen

  describe "Day 14 code" do
    test "solves part 1" do
      assert Fourteen.part1() == 728
    end

    test "solves part 2" do
      assert Fourteen.part2() == 27623
    end
  end
end
