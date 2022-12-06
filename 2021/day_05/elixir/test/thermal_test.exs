defmodule ThermalTest do
  use ExUnit.Case
  doctest Thermal

  test "Finds Thermal Vents with rating 2 or more (no diagonal lines)" do
    assert Thermal.part1() == 6311
  end

  test "Finds Thermal Vents with rating 2 or more" do
    assert Thermal.part2() == 19929
  end
end
