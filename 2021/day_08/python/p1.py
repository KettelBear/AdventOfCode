from tools import get_input


def solution():
    signals = get_input("input.prod")

    total_unique = 0
    for sig in signals:
        [_garbage, output] = sig.split(" | ")
        for value in output.split():
            if len(value) in [2, 3, 4, 7]:
                total_unique += 1

    return total_unique


print(solution())
