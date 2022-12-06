defmodule DiagnosticsTest do
  use ExUnit.Case
  doctest Diagnostics

  test "Multiplies the gamma by epsilon readings" do
    assert Diagnostics.part1() == 4160394
  end

  test "Multiplies the oxygen by carbion dioxide readings" do
    assert Diagnostics.part2() == 4125600
  end
end
