import heapq
from tools import get_input


def solve(n_tiles):
    data = get_input('input.prod')

    G = []
    for line in data:
        G.append([int(x) for x in line])
    R = len(G)
    C = len(G[0])
    DR = [-1, 0, 1, 0]
    DC = [0, 1, 0, -1]

    D = [[None for _ in range(n_tiles*C)] for _ in range(n_tiles*R)]
    Q = [(0, 0, 0)]
    while Q:
        (dist, r, c) = heapq.heappop(Q)
        if r < 0 or r >= n_tiles*R or c < 0 or c >= n_tiles*C:
            continue

        val = G[r % R][c % C] + (r//R) + (c//C)
        while val > 9:
            val -= 9
        rc_cost = dist + val

        if D[r][c] is None or rc_cost < D[r][c]:
            D[r][c] = rc_cost
        else:
            continue
        if r == n_tiles*R-1 and c == n_tiles*C-1:
            break

        for d in range(4):
            rr = r+DR[d]
            cc = c+DC[d]
            heapq.heappush(Q, (D[r][c], rr, cc))
    return D[n_tiles*R-1][n_tiles*C-1] - G[0][0]


if __name__ == "__main__":
    print(solve(1))
    print(solve(5))
