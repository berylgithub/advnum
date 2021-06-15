% E54(i):
%random points:
##rand ("state", 3);
##x = rand (5, 1);
##y = rand (5, 1);
% square:
x = [0 1 0 1];
y = [0 0 1 1];
tri = delaunay (x, y);
triplot (tri, x, y);
hold on;
plot (x, y, "r*");
figure();
%axis ([0,1,0,1]);
% refinement:
x0 = [1 1]; %any points
r = 1;
[x_new, y_new] = grid_refinement(x0, r, x, y, tri);
% new points after refinement:
tri = delaunay (x_new, y_new);
triplot (tri, x_new, y_new);
hold on;
plot (x_new, y_new, "r*");
figure();

% E54(ii):
##% L-shaped geometry (grid-labelling):
x = [0 1 2 0 1 2 0 1 2];
y = [2 2 2 1 1 1 0 0 0];
n = 4; %num of refinement
r = sqrt(2); %search radius
idx = [1 2 4 5]; %top left square
% n-times refinement:
x0 = [0 1];
x_1 = x(idx); y_1 = y(idx);
tri = delaunay (x_1, y_1);
for i=1:n
  [x_1, y_1] = grid_refinement(x0, r, x_1, y_1, tri);
  tri = delaunay(x_1, y_1);
endfor
triplot (tri, x_1, y_1);
hold on;
plot (x_1, y_1, "r*");
figure();

idx = [4 5 7 8]; %bottome left square
% n-times refinement:
x0 = [0 0];
x_2 = x(idx); y_2 = y(idx);
tri_1 = delaunay (x_2, y_2);
for i=1:n
  [x_2, y_2] = grid_refinement(x0, r, x_2, y_2, tri_1);
  tri_1 = delaunay(x_2, y_2);
endfor
triplot (tri_1, x_2, y_2);
hold on;
plot (x_2, y_2, "r*");
figure();

idx = [5 6 8 9]; %bottom right square
% n-times refinement:
x0 = [1 0];
x_3 = x(idx); y_3 = y(idx);
tri_2 = delaunay (x_3, y_3);
for i=1:n
  [x_3, y_3] = grid_refinement(x0, r, x_3, y_3, tri_2);
  tri_2 = delaunay(x_3, y_3);
endfor
triplot (tri_2, x_3, y_3);
hold on;
plot (x_3, y_3, "r*");
figure();

##disp(tri);
##tri_1 = tri + 6
##tri_2 = tri_1 + 1
##tri_comb = [tri; tri_1; tri]
##x_comb = [x_1 x_2 x_3];
##y_comb = [y_1 y_2 y_3];
##triplot (tri_comb, x_comb, y_comb);
##hold on;
##plot (x_comb, y_comb, "r*");
##figure();
