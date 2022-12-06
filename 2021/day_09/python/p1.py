from tools import get_input


def is_low_point(height_map, x, y):
    point = height_map[x][y]

    return not (
        x + 1 < len(height_map) and height_map[x+1][y] <= point
        or y + 1 < len(height_map[0]) and height_map[x][y+1] <= point
        or x - 1 > -1 and height_map[x-1][y] <= point
        or y - 1 > -1 and height_map[x][y-1] <= point
    )


def solution():
    height_map = []

    # Generate 2d array of heights
    for height in get_input("input.prod"):
        height_map.append([int(x) for x in height])

    # Collect local minimums to sum later
    local_mins = []
    for x in range(len(height_map)):
        for y in range(len(height_map[0])):
            if is_low_point(height_map, x, y):
                local_mins.append(height_map[x][y])

    # len(local_mins) is the +1 on each min
    return sum(local_mins) + len(local_mins)


print(solution())
