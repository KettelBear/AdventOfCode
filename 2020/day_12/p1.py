from tools import get_input

turnLeft = {
    'N': 'W',
    'W': 'S',
    'S': 'E',
    'E': 'N'
}

turnRight = {
    'N': 'E',
    'E': 'S',
    'S': 'W',
    'W': 'N'
}


def split_direction(line):
    '''
    Simply splits the command from the value.
    '''
    return line[0], int(line[1:])


def move(curr, direction, magnitude):
    '''
    Moves the ship in the cardinal direction.
    '''
    x, y = curr
    if direction == 'N':
        x += magnitude
    elif direction == 'E':
        y += magnitude
    elif direction == 'S':
        x -= magnitude
    elif direction == 'W':
        y -= magnitude

    return (x, y)


def change_point(facing, rotation, degrees):
    '''
    Changes the direction the ship is facing.
    '''
    if degrees == 180:
        if facing in ['N', 'S']:
            return 'N' if facing == 'S' else 'S'
        return 'W' if facing == 'E' else 'E'

    if degrees == 270:
        rotation = 'L' if rotation == 'R' else 'R'
        degrees = 90

    if rotation == 'L':
        return turnLeft[facing]

    return turnRight[facing]


def follow_directions():
    '''
    The ship starts by facing east, and at the point of origin.
    Let negative numbers represent south and west, even though,
    ultimately it is arbitrary.
    '''
    directions = get_input()

    facing = 'E'
    x = y = 0
    pos = (x, y)
    for direction in directions:
        instr, val = split_direction(direction)

        if instr in ['N', 'E', 'S', 'W']:
            pos = move(pos, instr, val)
        elif instr == 'F':
            pos = move(pos, facing, val)
        else:
            facing = change_point(facing, instr, val)

    x, y = pos
    return abs(x) + abs(y)


results = follow_directions()

print(results)
