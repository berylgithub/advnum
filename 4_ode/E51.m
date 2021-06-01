N = 3
h = 1/(N+1);
A = diag(4*ones(1,N)) + diag(-1*ones(1,N-1),1) + diag(-1*ones(1,N-1),-1);
disp(A)