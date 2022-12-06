defmodule AssemblyRequiredTest do
  use ExUnit.Case
  doctest AssemblyRequired

  test "Signal provided to wire 'a'" do
    assert AssemblyRequired.part1() == 956
  end

  test "New signal provided to wire 'a'" do
    assert AssemblyRequired.part2() == 40149
  end
end
