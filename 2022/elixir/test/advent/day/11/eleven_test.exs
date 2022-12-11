defmodule Advent.Day.ElevenTest do
  use ExUnit.Case

  alias Advent.Day.Eleven

  describe "Day 11 code" do
    test "solves part 1" do
      assert Eleven.part1() == 100_345
    end

    test "solves part 2" do
      assert Eleven.part2() == 28_537_348_205
    end
  end
end
