%random points:
##rand ("state", 3);
##x = rand (5, 1);
##y = rand (5, 1);
% square:
x = [0 1 0 1];
y = [0 0 1 1];
tri = delaunay (x, y)
triplot (tri, x, y);
hold on;
plot (x, y, "r*");
figure();
#axis ([0,1,0,1]);

% refinement:
x0 = [0 0]; %any points
r = 2;
[x_new, y_new] = grid_refinement(x0, r, x, y, tri);
% new points after refinement:
tri = delaunay (x_new, y_new);
triplot (tri, x_new, y_new);
hold on;
plot (x_new, y_new, "r*");