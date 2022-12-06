from tools import get_input


def solution():
    inputs = get_input("input.prod")

    lowest = 999999999
    for i in range(min(inputs), max(inputs) + 1):
        sum_ = 0
        for inp in inputs:
            sum_ += abs(i - inp)

        if sum_ < lowest:
            lowest = sum_

    return lowest


print(solution())
