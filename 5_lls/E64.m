% inputs, the matrix A should be replaced with function handle later
A = [1 1; 3 -4]; %dummy test, sol is (2,1)
b = [3 2]';
x0 = [1 2]'; %init guess
dim = size(A)(1);
k = 3; %maxiter
% GMRES:
% init:
H = zeros(k, k); %upper hessenberg
Q = zeros(dim, k); %Q matrix
x = zeros(dim, k); %result matrix
% algo
r = b - A*x0;
b = zeros(k, 1); %for backslash
b(1) = norm(r);
Q(:,1) = r/norm(r); %first q vec from residal
for i=1:k
  %arnoldi:
  y = A*Q(:,i); %replace with func handle
  for j=1:i
    H(j,i) = Q(:,j)'*y;
    y -= H(j,i)*Q(:,j);
  endfor
  H(i+1,i) = norm(y);
  if (H(i+1,i) != 0) && (i!=k)  %check if entry is 0 
    Q(:,i+1) = y/H(i+1,i);
  endif  
  z = H(1:k, 1:k)\b; %replace with function handle
  x(:,i) = Q*z + x0; %store results
endfor
disp("value of x is (final column is the final approx)")
x
