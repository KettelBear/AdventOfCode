from tools import get_input


class Node:
    def __init__(self, name) -> None:
        self.name = name
        self.is_lower = True if name.islower() else False
        self.connections = set()
        self.is_visited = False

    def add_connection(self, connection):
        self.connections.add(connection)

    def get_connections(self):
        return self.connections

    def visit(self):
        self.is_visited = True

    def unvisit(self):
        self.is_visited = False

    def has_been_visited(self):
        return self.is_lower and self.is_visited

    def print_connections(self):
        for conn in self.connections:
            print(conn)


def upsert_node(graph, node_name, connection):
    node = graph.get(node_name)
    if node is None:
        node = Node(node_name)
        node.add_connection(connection)
        graph[node_name] = node
    else:
        node.add_connection(connection)


def build_graph(connections):
    graph = dict()

    for connection in connections:
        node1, node2 = connection.split('-')

        upsert_node(graph, node1, node2)
        upsert_node(graph, node2, node1)

    return graph


def paths(graph, start, destination, path, count):
    graph[start].visit()
    path.append(start)

    if start == destination:
        count += 1
    else:
        for i in graph[start].get_connections():
            if not graph[i].has_been_visited():
                count = paths(graph, i, destination, path, count)

    path.pop()
    graph[start].unvisit()

    return count


def solution():
    data = get_input("input.prod")

    graph = build_graph(data)

    return paths(graph, 'start', 'end', list(), 0)


if __name__ == "__main__":
    print(solution())
