from tools import get_input


def coords_to_str(x, y):
    return str(x) + ',' + str(y)


def handle_line(map, x1, y1, x2, y2):
    x_mod = 0 if x1 == x2 else 1 if x1 < x2 else -1
    y_mod = 0 if y1 == y2 else 1 if y1 < y2 else -1

    while coords_to_str(x1, y1) != coords_to_str(x2 + x_mod, y2 + y_mod):
        coordinate = coords_to_str(x1, y1)

        if map.get(coordinate) is None:
            map[coordinate] = 1
        else:
            map[coordinate] += 1

        x1 += x_mod
        y1 += y_mod

    return map


def solution():
    data = get_input("input.prod")

    hydro_map = {}

    for datum in data:
        [first, second] = datum.split(' -> ')
        [x1, y1] = [int(x) for x in first.split(',')]
        [x2, y2] = [int(x) for x in second.split(',')]

        hydro_map = handle_line(hydro_map, x1, y1, x2, y2)

    count = 0
    for hydro in hydro_map.values():
        if hydro > 1:
            count += 1

    return count

print(solution())
