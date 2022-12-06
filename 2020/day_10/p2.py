from tools import get_input, Graph


def day_10():
    values = get_input()

    values.sort()

    values.insert(0, 0)
    values.append(values[-1] + 3)

    subgraphs = []
    choke_point = 3
    i = 0
    itr = 1
    for itr in range(len(values)):
        if values[itr] - values[itr-1] == choke_point:
            subgraphs.append(values[i:itr])
            i = itr

    total = 1
    for sub in subgraphs:
        dict = {}

        for i in range(len(sub)):
            dict[sub[i]] = []
            itr = i + 1
            while itr < i+4:
                try:
                    if sub[itr] - sub[i] < 4:
                        dict[sub[i]].append(sub[itr])
                except:
                    pass
                itr += 1

        graph = Graph(dict)

        total *= graph.countAllPaths(sub[0], sub[-1])

    return total


print(day_10())
