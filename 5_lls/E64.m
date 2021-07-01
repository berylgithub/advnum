warning('off','all')
% inputs, the matrix A should be replaced with function handle later
A = [1 1; 3 -4] %dummy test, sol is (2,1)
b = [3 2]'
x0 = [0 0]' %init guess
dim = size(A)(1);
%dim = 5;
%a0 = randi([4 7],dim,1);
%a1 = a0 - 2;
%a1min = flip(a1);
%a2 = a1 - 1;
%a2min = flip(a2);
%A = diag(a0) + diag(a1(1:dim-1),1) + diag(a1min(1:dim-1),-1) + diag(a2(1:dim-2),2) + diag(a2min(1:dim-2),-2)
%x0 = rand(dim, 1);
%b = ones(dim, 1);
k = 2; %maxiter
%gmres_num(A, b, x0, k, dim, A*x0)
k_outer = 1;
x = x0;
w = b; %preserve b
for i=1:k_outer
  B = sparse(diag(diag(A)));
  w = -pAxpy(A,B,x, -w); %paxpy
  x += gmres_num(A, w, x, k, dim, @pAxpy(A, B, x, 0))
endfor
disp("||x_gmres - solve(A,b)||:")
norm(x - (A\b))