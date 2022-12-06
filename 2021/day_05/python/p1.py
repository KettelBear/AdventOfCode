from tools import get_input


def crds(x, y):
    return str(x) + ',' + str(y)


def handle_horiz(map, x, y1, y2):
    if y1 > y2:
        for i in range(y2, y1 + 1):
            coord = crds(x, i)
            if map.get(coord) is None:
                map[coord] = 1
            else:
                map[coord] += 1
    else:
        for i in range(y1, y2 + 1):
            coord = crds(x, i)
            if map.get(coord) is None:
                map[coord] = 1
            else:
                map[coord] += 1

    return map


def handle_vert(map, y, x1, x2):
    if x1 > x2:
        for i in range(x2, x1 + 1):
            coord = crds(i, y)
            if map.get(coord) is None:
                map[coord] = 1
            else:
                map[coord] += 1
    else:
        for i in range(x1, x2 + 1):
            coord = crds(i, y)
            if map.get(coord) is None:
                map[coord] = 1
            else:
                map[coord] += 1

    return map


def solution():
    data = get_input("input.prod")

    hydro_map = {}

    for datum in data:
        [first, second] = datum.split(' -> ')
        [x1, y1] = [int(x) for x in first.split(',')]
        [x2, y2] = [int(x) for x in second.split(',')]

        if x1 == x2:
            hydro_map = handle_horiz(hydro_map, x1, y1, y2)
        elif y1 == y2:
            hydro_map = handle_vert(hydro_map, y1, x1, x2)

    count = 0
    for hydro in hydro_map.values():
        if hydro > 1:
            count += 1

    return count


print(solution())