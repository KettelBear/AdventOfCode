defmodule SphericalHousesTest do
  use ExUnit.Case
  doctest SphericalHouses

  test "houses receive at least one present" do
    assert SphericalHouses.part1() == 2572
  end

  test "houses receive at least one present with robo santa" do
    assert SphericalHouses.part2() == 2631
  end
end
