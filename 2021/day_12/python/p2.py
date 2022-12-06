from tools import get_input


class Node:
    def __init__(self, name) -> None:
        self.name = name
        self.is_lower = True if name.islower() else False
        self.connections = set()
        self.num_of_visits = 0

    def add_connection(self, connection):
        # Prevent start from being retuned to
        if connection == 'start':
            return

        self.connections.add(connection)

    def get_connections(self):
        return self.connections

    def visit(self):
        self.num_of_visits += 1

    def unvisit(self):
        self.num_of_visits -= 1

    def get_visits(self):
        return self.num_of_visits

    def has_been_visited(self):
        return self.is_lower and self.num_of_visits > 0

    def get_is_lower(self):
        return self.is_lower

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


def has_double(graph, path):
    for p in path:
        node = graph[p]
        if node.get_is_lower() and node.get_visits() == 2:
            return True

    return False


def paths(graph, curr_node, destination, path, count):
    node = graph[curr_node]
    node.visit()
    path.append(curr_node)

    if curr_node == destination:
        count += 1
    else:
        for n in node.get_connections():
            if not has_double(graph, path) or not graph[n].has_been_visited():
                count = paths(graph, n, destination, path, count)

    path.pop()
    node.unvisit()

    return count


def solution(in_file):
    data = get_input(in_file)

    graph = build_graph(data)

    return paths(graph, 'start', 'end', list(), 0)


if __name__ == "__main__":
    print(solution("input.prod"))
