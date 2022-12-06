from tools import get_input


def split_direction(line):
    return line[0], int(line[1:])


def move_waypoint(waypoint, direction, magnitude):
    '''
    The waypoint is stored relative to the ships position.
    This will move the waypoint so many units in the given
    direction.
    '''
    x, y = waypoint
    if direction == 'N':
        x += magnitude
    elif direction == 'E':
        y += magnitude
    elif direction == 'S':
        x -= magnitude
    elif direction == 'W':
        y -= magnitude

    return (x, y)


def move(curr, waypoint, val):
    '''
    Move directions will now move the ship to the waypoint
    location, however many times over.
    '''
    x, y = curr
    delta_x, delta_y = waypoint
    x += (val * delta_x)
    y += (val * delta_y)

    return (x, y)


def rotate_waypoint(waypoint, rotation, degrees):
    '''
    Rotate the weightpoint clockwise, or counter clockwise
    about the ship. The ship can be treated like the point
    of origin (0,0) because the waypoints values are relative
    to the ship.
    '''
    if degrees == 180:
        return (waypoint[0] * -1, waypoint[1] * -1)

    if degrees == 270:
        rotation = 'R' if rotation == 'L' else 'L'

    if rotation == 'R':
        return (waypoint[1] * -1, waypoint[0])

    return (waypoint[1], waypoint[0] * -1)


def follow_directions():
    '''
    Follow the directions given the new set of rules, where only
    F means the ship moves, and the othe 6 instructions move the
    waypoint itself.
    '''
    directions = get_input()

    waypoint = (1, 10)
    x = y = 0
    pos = (x, y)
    for direction in directions:
        instr, val = split_direction(direction)

        if instr in ['N', 'E', 'S', 'W']:
            waypoint = move_waypoint(waypoint, instr, val)
        elif instr == 'F':
            pos = move(pos, waypoint, val)
        else:
            waypoint = rotate_waypoint(waypoint, instr, val)

    x, y = pos
    return abs(x) + abs(y)


results = follow_directions()

print(results)
