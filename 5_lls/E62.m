filename = "mm/memplus.mtx"
[A, rows, cols, entries] = mmread(filename);
r = 3;
U = V = rand(rows, r);
S = rand(r, r);
b = rand(rows, 1);
A += (U*S)*V';
tic;
x = A\b;
timer = toc;
disp(x);
disp(toc);