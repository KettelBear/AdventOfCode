from tools import get_input


def solution():
    instructions = get_input("input.prod")

    aim = 0
    distance = 0
    depth = 0
    for instr in instructions:
        [direction, vector] = instr.split(" ")
        if direction == "forward":
            distance += int(vector)
            depth += aim * int(vector)
        elif direction == "down":
            aim += int(vector)
        else:
            aim -= int(vector)

    return distance * depth


print(solution())
