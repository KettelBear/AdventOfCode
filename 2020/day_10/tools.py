from os.path import dirname, realpath, join


def get_input() -> list:
    dir_path = dirname(realpath(__file__))
    with open(join(dir_path, "input.txt"), "r") as infile:
        report = infile.read().splitlines()
    return [int(report[i]) for i in range(len(report))]


class Graph:
    '''
    Not my class, found online for printing all paths, and modified
    to instead count the paths.
    '''

    def __init__(self, graph):
        self.num_of_paths = 0
        self.graph = graph

    def countAllPathsUtil(self, node, destination, visited, path):
        visited[node] = True
        path.append(node)

        if node == destination:
            self.num_of_paths += 1
        else:
            for i in self.graph[node]:
                if visited[i] == False:
                    self.countAllPathsUtil(i, destination, visited, path)

        path.pop()
        visited[node] = False

    def countAllPaths(self, start, end):

        visited = {}
        for key in self.graph.keys():
            visited[key] = False

        path = []

        self.countAllPathsUtil(start, end, visited, path)

        return self.num_of_paths
