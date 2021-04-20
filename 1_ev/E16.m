format compact;
n = 15;
h = 1/(n+1);
P = 100;
alpha = 10.132115;
A = diag(2*ones(1,n)) + diag(-1*ones(1,n-1),1) + diag(-1*ones(1,n-1),-1);
A = sparse(A)*alpha/h^2
I = eye(n);
#inverse iteration w/ rayleigh quotient:
x = rand(n,1); #random pick
sigma = rand; #also random
el = 20;
for i=1:el
  xl = (A - sigma*I)\x;
  if ~all(isfinite(xl))
    break;
  end
  x = xl/norm(xl); #eigvec
  sigma = (x'*A*x)/(x'*x); #rayleigh quotient for eigval
  err = norm(A*x - sigma*x)/norm(x);
  disp(["iter = ",num2str(i),"; shift = ", num2str(sigma), "; error = ",num2str(err)]);
 end
disp("v = ");
disp(x);
disp(["difference with P (|sigma-P|) = ", num2str(abs(sigma-P))])