from tools import get_input


def parse_bag_rules(bags):
    '''
    Similar to part 1, this will parse the bag rules, however,
    the difference here is; this one will keep the number for
    counting later.
    '''
    if bags == 'no other bags.':
        return []

    colors = bags.split(', ')
    final_colors = []
    for color in colors:
        temp = color.split(' ')

        final_colors.append(temp[0]+' '+temp[1]+' '+temp[2])

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
        graph[bags[0]] = list(dict.fromkeys(graph[bags[0]]))

    return graph


def get_number_and_color(contents):
    '''
    This definition merely separates the number from the color
    of the bag.
    '''
    temp = contents.split(' ')
    return (int(temp[0]), temp[1] + ' ' + temp[2])


def count_bags_within(bags_within, graph):
    '''
    This is quite similar to the first part's recusive counting.
    Instead, this one recurses for each bag within another bag.
    There is a way to find the sum of the products, but this recursion
    was simpler to write in a short timespan.
    '''
    count = 0
    for bag in bags_within:
        (num_of_bag, bag_color) = get_number_and_color(bag)
        count += num_of_bag

        for i in range(num_of_bag):
            count += count_bags_within(graph[bag_color], graph)

    return count


def bags_within_gold():
    '''
    This simply graphs the bags, then calls for the count within the
    'shiny gold' bag. This can really be applied to any key.
    '''
    bag_graph = graph_bags()

    return count_bags_within(bag_graph['shiny gold'], bag_graph)


print(bags_within_gold())
