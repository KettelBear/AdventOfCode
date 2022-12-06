defmodule DisplayTest do
  use ExUnit.Case
  doctest Display

  test "Counts number of unique display digits" do
    assert Display.part1() == 504
  end

  test "Caluclates sum of display outputs" do
    assert Display.part2() == 1073431
  end
end
