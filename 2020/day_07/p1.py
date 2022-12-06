from tools import get_input


def parse_bag_rules(bags):
    '''
    This will parse the rules of what bags hold other colors.
    It will return an array of the colors that the bag holds.
    '''
    if bags == 'no other bags.':
        return []

    colors = bags.split(', ')
    final_colors = []
    for color in colors:
        temp = color.split(' ')

        final_colors.append(temp[1]+' '+temp[2])

    return final_colors


def graph_bags():
    '''
    Collects the input, and starts parsing it. First it'll
    split the string to collect the bag that contains other
    bags. Then it'll parse the 2nd half of the string to see
    what bags that bag contained.
    '''
    rules = get_input()

    graph = {}
    for rule in rules:
        bags = rule.split(' bags contain ')
        if graph.get(bags[0]) is not None:
            graph[bags[0]] += parse_bag_rules(bags[1])
        else:
            graph[bags[0]] = parse_bag_rules(bags[1])

        # Make sure there are no duplicates
        graph[bags[0]] = list(dict.fromkeys(graph[bags[0]]))

    return graph


def contains_gold(bag_list, graph):
    '''
    The bag_list is the list of bags contained within the
    caller of the function. It'll iterate recursively to
    see if the top level bag contains a shiney gold bag.
    '''
    if 'shiny gold' in bag_list:
        return True
    elif not bag_list:
        return False

    for val in bag_list:
        if contains_gold(graph[val], graph):
            return True
    return False


def count_bags_with_gold():
    '''
    First, this will call for the graph of bags. Then it'll
    call the recursive function to find how many top level
    bags at some point contain a 'shiny gold' bag.
    '''
    bag_graph = graph_bags()

    count = 0
    for value in bag_graph.values():
        if contains_gold(value, bag_graph):
            count += 1

    return count


print(count_bags_with_gold())
