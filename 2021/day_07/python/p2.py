from tools import get_input


def solution():
    inputs = get_input("input.prod")

    lowest = 999999999
    for i in range(min(inputs), max(inputs) + 1):
        sum_ = 0
        for inp in inputs:
            # The sum of integers between the two: (n * (n + 1)) / 2
            fuel_burned = int((abs(i - inp) * (abs(i - inp) + 1)) / 2)
            sum_ += fuel_burned

        if sum_ < lowest:
            lowest = sum_

    return lowest


print(solution())
