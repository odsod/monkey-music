import heapq
import util

WALL = ('W', '#')
USER = ('U',)
NOT_ALLOWED = ('?', '-')
UNREACHABLE = WALL + USER + NOT_ALLOWED

class PathFinder(object):
    def __init__(self, world):
        self._world = world

    def find_path(self, start, goal):
        visited = set()
        path_cost = {start: 0}
        parent = {}
        queue = [(0, start)]
        while queue:        
            cost, current = heapq.heappop(queue)
            if current == goal:
                path = [current]
                while current in parent:
                    path.append(parent[current])
                    current = parent[current]
                path.reverse()
                return path
            visited.add(current)
            if not self.reachable(current):
                continue
            for node in self.adjacent_nodes(current):
                if node not in visited:
                    if (node not in path_cost) or (path_cost[current] + 1 < path_cost[node]):
                        path_cost[node] = path_cost[current] + 1
                        parent[node] = current
                    estimated_cost = path_cost[node] + util.distance(node, goal)
                    heapq.heappush(queue, (estimated_cost, node))
                    
    def adjacent_nodes(self, current):
        x, y = current
        for d_pos in util.D_POS.itervalues():
            dx, dy = d_pos
            yield (x + dx, y + dy)                  
            
    def reachable(self, pos):
        try:
            square = self._world[pos]
            return square not in UNREACHABLE
        except KeyError:
            return False
