A = [-4 10 8; 10 -7 2; 8 -2 3];
[V,D] = eig(A)
n = length(A);
I = eye(n);
sigma = diag(D)(1) #initial shift using the value from eig(A)
x = rand(n,1) #random pick
%gamma = 0.01 # != 0 const
[x, sigma] = inverse_iteration(A, I, x, sigma, 5)
