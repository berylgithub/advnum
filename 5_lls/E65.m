rows = 2
cols = 3
M = grid_generator(rows, cols);
[distances, prev] = dijkstra_num(M, 1);
distances
prev
