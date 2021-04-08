A = [-4 10 8; 10 -7 2; 8 -2 3];
[V,D] = eig(A)
n = length(A);
I = eye(n);
eigvals = diag(D);
len = length(eigvals)
for i=1:len
  disp([">>>Shift no.: ", num2str(i)])
  sigma = diag(D)(i) #initial shift using the value from eig(A)
  x = rand(n,1) #random pick
  [x, sigma] = inverse_iteration(A, I, x, sigma, 5)
  disp("================")
end