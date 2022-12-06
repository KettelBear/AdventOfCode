from math import prod
from tools import get_input


def get_valid_neighbors(height_map, x, y):
    valid_neighbors = set()

    # Get all valid neighbors for a given point in the basin
    if x + 1 < len(height_map) and height_map[x+1][y] != 9:
        valid_neighbors.add((x + 1, y))
    if y + 1 < len(height_map[0]) and height_map[x][y+1] != 9:
        valid_neighbors.add((x, y + 1))
    if x - 1 > -1 and height_map[x-1][y] != 9:
        valid_neighbors.add((x - 1, y))
    if y - 1 > -1 and height_map[x][y-1] != 9:
        valid_neighbors.add((x, y - 1))

    return valid_neighbors


def track_basin(height_map, x, y):
    basin = set({(x, y)})

    old_basin_size = len(basin)
    basin_size = 0

    # `tmp` will be a growing collection of valid neighbors for each point
    tmp = set()

    # `new_points` are going to be points that we haven't seen before
    # and we'll check for valid neighbors for each new point part of the
    # basin.
    new_points = basin.copy()

    # If the basin size keeps changing, keep running the loop over the
    # new points found.
    while old_basin_size != basin_size:
        old_basin_size = basin_size
        for point in new_points:
            i, j = point[0], point[1]
            tmp.update(get_valid_neighbors(height_map, i, j))

        # After collecting valid basin points in `tmp`, get the difference
        # from the current basin, to find the new points to explore.
        new_points = tmp.difference(basin)
        basin.update(tmp)
        basin_size = len(basin)

    return basin


def is_low_point(height_map, x, y):
    point = height_map[x][y]

    # I don't want apply De Morgan's law to remove that `not`
    # so I am leaving it there.
    return not (
        x + 1 < len(height_map) and height_map[x+1][y] <= point
        or y + 1 < len(height_map[0]) and height_map[x][y+1] <= point
        or x - 1 > -1 and height_map[x-1][y] <= point
        or y - 1 > -1 and height_map[x][y-1] <= point
    )


def update_basin_sizes(basin_sizes, basin):
    # Gross, but only want to keep track of 3 largest basins.
    if basin > basin_sizes[0]:
        basin_sizes[2] = basin_sizes[1]
        basin_sizes[1] = basin_sizes[0]
        basin_sizes[0] = basin
    elif basin > basin_sizes[1]:
        basin_sizes[2] = basin_sizes[1]
        basin_sizes[1] = basin
    elif basin > basin_sizes[2]:
        basin_sizes[2] = basin


def solution():
    height_map = []

    # Generate 2d array of our height map
    for height in get_input("input.prod"):
        height_map.append([int(x) for x in height])

    # Collect all the local minimums (part 1),
    # but store coordinates of the local min
    local_mins = set()
    for x in range(len(height_map)):
        for y in range(len(height_map[0])):
            if is_low_point(height_map, x, y):
                local_mins.add((x, y))

    # For each local min, find and track the largest 3 basins
    basin_sizes = [0, 0, 0]
    for lmin in local_mins:
        size = len(track_basin(height_map, lmin[0], lmin[1]))
        update_basin_sizes(basin_sizes, size)

    return prod(basin_sizes)


print(solution())
