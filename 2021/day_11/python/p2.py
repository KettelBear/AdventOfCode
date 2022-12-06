from tools import get_input


def increase_energy(o_map):
    for x in range(10):
        for y in range(10):
            o_map[x][y] += 1


def handle_flashes(o_map):
    flashes = 0

    has_ten = True
    while has_ten:
        has_ten = False
        for x in range(10):
            for y in range(10):
                if o_map[x][y] == 10:
                    has_ten = True
                    o_map[x][y] = 0
                    flashes += 1
                    inc_neighbor_energy(o_map, x, y)

    return flashes


def inc_neighbor_energy(o_map, x, y):
    for i in [-1, 0, 1]:
        for j in [-1, 0, 1]:
            if i == 0 and j == 0:
                continue
            row = x + i
            col = y + j
            if -1 < row < 10 and -1 < col < 10 and o_map[row][col] not in [0, 10]:
                o_map[row][col] += 1


def get_octopi_map():
    data = get_input("input.prod")

    o_map = list()
    for datum in data:
        o_map.append([int(flash_level) for flash_level in datum])

    return o_map


def solution():
    o_map = get_octopi_map()

    steps = 0
    sum_ = -1
    while sum_ != 0:
        increase_energy(o_map)
        handle_flashes(o_map)
        steps += 1

        tmp = 0
        for row in o_map:
            tmp += sum(row)

        sum_ = tmp

    return steps


print(solution())
