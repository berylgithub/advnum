warning('off','all')
iters = 200
tol = 1e-5;
max_power = 6; 
maxiters = zeros(max_power, 3);
for i=1:max_power
  % input data:
  rows = cols = 2^i;
  % laplace matrix:
  A = grid_generator(rows, cols);
  A(1:size(A,1)+1:end) = -4;
  dim = size(A)
  % right hand side:
  b = ones(dim, 1);
  
  % Actual solution:
  sol = A\b; %actual solution
  
  % standard GMRES:
  x0 = zeros(dim, 1); %initial guess
  [x, max_iter] = gmres_num_tol(A, b, x0, iters, dim, A*x0, tol, sol);
  maxiters(i,1) = max_iter;
  disp(["GMRES reached the required error tolerance in ",num2str(max_iter), " iterations"])
  disp(["Error = ",num2str(norm(x - sol))])
  
  % preconditioned GMRES using ilu:
  [L,U] = ilu(A); % L*U
  M = L*U; %preconditioner
  Minv = inv(M);
  Acond = Minv*A;
  bcond = Minv*b;
  ##disp(["Condition number of A = ", num2str(cond(A))])
  ##disp(["Condition number of LU = ", num2str(cond(M))])
  ##disp(["Condition number of M^-1 * A = ", num2str(cond(Acond)), " is closest I"]) 
  [x_cond, max_iter_cond] = gmres_num_tol(Acond, bcond, x0, iters, dim, A*x0, tol, sol);
  maxiters(i,2) = max_iter_cond;
  diff = norm(x_cond - sol);
  disp(["Preconditioned GMRES reached the required error tolerance in ",num2str(max_iter_cond), " iterations"])
  disp(["Error = ",num2str(norm(x_cond - sol))])
  
  % reordered and preconditioned
  r = amd(A); %should replace with nested dissection
  A = A(r,r);
  sol = A\b; %reordered actual solution
  [L,U] = ilu(A); % L*U
  M = L*U; %preconditioner
  Minv = inv(M);
  Acond = Minv*A;
  bcond = Minv*b;
  [x_cond, max_iter_cond] = gmres_num_tol(Acond, bcond, x0, iters, dim, A*x0, tol, sol);
  maxiters(i,3) = max_iter_cond;
  diff = norm(x_cond - sol);
  disp(["Precond+reordered GMRES reached the required error tolerance in ",num2str(max_iter_cond), " iterations"])
  disp(["Error = ",num2str(norm(x_cond - sol))])
  disp(" ")
endfor
plot(maxiters(:,1), "r-*-")
hold on
plot(maxiters(:,2), "g-+-")
hold on
plot(maxiters(:,3), "b-+-")
xlabel("dim power");
ylabel("iter")
legend('standard','preconditioned', 'reordered+precond')
