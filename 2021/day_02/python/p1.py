from tools import get_input


def solution():
    instructions = get_input("input.prod")

    distance = 0
    depth = 0
    for instr in instructions:
        [direction, vector] = instr.split(" ")
        if direction == "forward":
            distance += int(vector)
        elif direction == "down":
            depth += int(vector)
        else:
            depth -= int(vector)

    return distance * depth


print(solution())
