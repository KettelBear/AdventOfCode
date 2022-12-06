defmodule SonarTest do
  use ExUnit.Case
  doctest Sonar

  test "Scans and finds increasing depths" do
    assert Sonar.part1() == 1462
  end

  test "Scans and finds increasing sums of depths" do
    assert Sonar.part2() == 1497
  end
end
