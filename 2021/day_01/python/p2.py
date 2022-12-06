from tools import get_input

def solution():
    depths = [int(x) for x in get_input("input.prod")]

    total = 0
    for i in range(4, len(depths)):
        if depths[i] > depths[i-3]:
            total += 1

    return total

print(solution())
