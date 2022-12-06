from tools import get_input


def add_perimiter(square):
    for row in square:
        row.insert(0, '.')
        row.append('.')
    additional = ['.' for _ in range(len(square[0]))]
    square.insert(0, additional)
    square.append(additional)

    return square


def add_squares(cube):
    square = []
    for i in range(len(cube[0])):
        square.append([])
        for _ in range(len(cube[0][0])):
            square[i].append('.')
    cube.insert(0, square)
    cube.append(square)
 
    return cube


def get_empty_cube(cube):
    new_cube = []
    for a in range(len(cube)):
        new_cube.append([])
        for b in range(len(cube[0])):
            new_cube[a].append([])
            for _ in range(len(cube[0][0])):
                new_cube[a][b].append('.')

    return new_cube


def add_layers(hyper_cube):
    for cube in hyper_cube:
        for square in cube:
            square = add_perimiter(square) 
        cube = add_squares(cube)        

    hyper_cube.insert(0, get_empty_cube(hyper_cube[0]))
    hyper_cube.append(get_empty_cube(hyper_cube[0]))

    return hyper_cube


def count_neighbors(x, y, z, w, hyper_cube):
    count = 0
    for a in range(x-1, x+2):
        for b in range(y-1, y+2):
            for c in range(z-1, z+2):
                for d in range(w-1, w+2):
                    if a == x and b == y and c == z and d == w:
                        continue
                    try:
                        if hyper_cube[a][b][c][d] == '#':
                            count += 1
                    except:
                        pass

    return count


def goes_on(x, y, z, w, hyper_cube):
    return count_neighbors(x, y, z, w, hyper_cube) == 3


def stay_on(x, y, z, w, hyper_cube):
    return 1 < count_neighbors(x, y, z, w, hyper_cube) < 4


def flip_hyper_cubes(hyper_cube):
    next_hyper_cube = []
    for x in range(len(hyper_cube)):
        next_hyper_cube.append([])
        for y in range(len(hyper_cube[0])):
            next_hyper_cube[x].append([])
            for z in range(len(hyper_cube[0][0])):
                next_hyper_cube[x][y].append([])
                for w in range(len(hyper_cube[0][0][0])):
                    if hyper_cube[x][y][z][w] == '.':
                        next_hyper_cube[x][y][z].append(
                            '#' if goes_on(x, y, z, w, hyper_cube) else '.')
                    else:
                        next_hyper_cube[x][y][z].append(
                            '#' if stay_on(x, y, z, w, hyper_cube) else '.')

    return next_hyper_cube


def day_17():
    values = get_input().splitlines()
    hyper_cube = []
    cube = []
    square = []
    for val in values:
        square.append([c for c in val])
    cube.append(square)
    hyper_cube.append(cube)
    for _ in range(6):
        hyper_cube = add_layers(hyper_cube)
        hyper_cube = flip_hyper_cubes(hyper_cube)

    count = 0
    for x in hyper_cube:
        for y in x:
            for z in y:
                for w in z:
                    if w == '#':
                        count += 1

    return count


results = day_17()

print('Puzzle Answer:', results)
