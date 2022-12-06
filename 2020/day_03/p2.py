from tools import get_input


def count_trees(rise: int, run: int, tree_map: list) -> int:
    '''
    In part two, we have the same case as part one, but we allow the slope of
    traversing the map to be passed in as a parameter.
    '''
    trees = 0
    x = y = 0
    while y < len(tree_map):
        if tree_map[y][x] == '#':
            trees += 1
        x = (x + run) % (len(tree_map[0]))
        y += rise

    return trees


def get_product() -> int:
    '''
    The puzzle was to get the product of multiple routes. This helper function
    keeps track of, and then returns, the product.
    '''
    tree_map = get_input()
    slopes = [
        {'rise': 1, 'run': 1},
        {'rise': 1, 'run': 3},
        {'rise': 1, 'run': 5},
        {'rise': 1, 'run': 7},
        {'rise': 2, 'run': 1}
    ]

    product = 1
    for slope in slopes:
        product *= count_trees(slope['rise'], slope['run'], tree_map)

    return product


print(get_product())
