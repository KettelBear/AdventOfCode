from tools import get_input

def solution():
    depths = [int(x) for x in get_input("input.prod")]

    total = 0
    for i in range(1, len(depths)):
        if depths[i] > depths[i-1]:
            total += 1

    return total

print(solution())
