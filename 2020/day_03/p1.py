from tools import get_input


def count_trees(tree_map: list) -> int:
    '''
    Taking a map (list of strings, where the strings are of equal length), we'll
    take a route across the map, moving down 1 unit and across 3 units. In this
    scenario the columns are infinite. Each time we come across a tree (#), we
    can increment the counter by 1. It will return the total number of trees
    found in the route. 
    '''
    trees = 0
    x = y = 0

    # Columns are infinite, but rows are finite.
    while y < len(tree_map):
        if tree_map[y][x] == '#':
            trees += 1
        x = (x + 3) % (len(tree_map[0]))
        y += 1

    return trees


print(count_trees(get_input()))
