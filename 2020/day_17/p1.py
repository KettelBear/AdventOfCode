from tools import get_input


def add_layers(cube):
    for square in cube:
        for row in square:
            row.insert(0, '.')
            row.append('.')
        additional = ['.' for _ in range(len(square[0]))]
        square.insert(0, additional)
        square.append(additional)

    layer = []
    for i in range(len(cube[0])):
        layer.append([])
        for _ in range(len(cube[0][0])):
            layer[i].append('.')
    cube.insert(0, layer)
    cube.append(layer)

    return cube


def count_neighbors(x, y, z, cube):
    count = 0
    for a in range(x-1, x+2):
        for b in range(y-1, y+2):
            for c in range(z-1, z+2):
                if a == x and b == y and c == z:
                    continue
                try:
                    if cube[a][b][c] == '#':
                        count += 1
                except:
                    pass

    return count


def goes_on(x, y, z, cube):
    return count_neighbors(x, y, z, cube) == 3


def stay_on(x, y, z, cube):
    return 1 < count_neighbors(x, y, z, cube) < 4


def flip_cubes(cube):
    next_cube = []
    for x in range(len(cube)):
        next_cube.append([])
        for y in range(len(cube[0])):
            next_cube[x].append([])
            for z in range(len(cube[0][0])):
                if cube[x][y][z] == '.':
                    next_cube[x][y].append(
                        '#' if goes_on(x, y, z, cube) else '.')
                else:
                    next_cube[x][y].append(
                        '#' if stay_on(x, y, z, cube) else '.')
    return next_cube


def day_17():
    values = get_input().splitlines()
    cube = []
    grid = []
    for val in values:
        grid.append([c for c in val])
    cube.append(grid)
    for _ in range(6):
        cube = add_layers(cube)
        cube = flip_cubes(cube)

    count = 0
    for x in cube:
        for y in x:
            for z in y:
                if z == '#':
                    count += 1
    return count


results = day_17()

print('Puzzle Answer:', results)
