defmodule Advent.Day.SevenTest do
  use ExUnit.Case

  alias Advent.Day.Seven

  describe "Day 7 code" do
    test "solves part 1" do
      assert Seven.part1() == 1667443
    end

    test "solves part 2" do
      assert Seven.part2() == 8998590
    end
  end
end
