format long;
format compact;
A = [-4 10 8; 10 -7 -2; 8 -2 3];
[V, D] = eig(A)
n = length(A);
I = eye(n);
eigvals = diag(D);
for i=1:n
  disp([">>>Shift no.: ", num2str(i)])
  sigma = eigvals(i) #initial shift using the value from eig(A)
  x = rand(n,1); #random pick
  [x, lambda] = inverse_iteration(A, I, x, sigma, 5)
  disp("================")
end