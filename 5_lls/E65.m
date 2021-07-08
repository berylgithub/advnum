% Attempts on nested dissection
rows = 32
cols = 16
M = grid_generator(rows, cols);
subplot(1,3,1); spy(M);
e = nested_dissection_num(M, 4);
subplot(1,3,2); spy(M(e, e));
e = nested_dissection_num(M, 32);
subplot(1,3,3); spy(M(e, e));