% E52
N = [10 100 1000];
method = [1 2 3];
##c=1
L = pi;
T = 10;
h = 2^(-5); %2^(-k)
t = linspace(0, 10, T/h + 1);
it = 1; %element of N
dx = mesh_size = L/N(it);
x = -L:mesh_size:L;
len = length(x);
##x = linspace(-L, L, N(it)+1);
##dx = x(2) - x(1); %sample any 2 points, probably should be mesh size?
dx2 = dx^2;
global A; % for fun input
A = sparse( eye(len-2)*(-2/dx2) + diag(ones(len-3,1), 1)/dx2 + diag(ones(len-3,1), -1)/dx2 ); %u_xx coeff matrix finite diff
u0 = sin(x) + sin(9*x); %initial condition
##plot(x, u0); %check the init cond
##figure();
u0_slice = u0(2:end-1)'; % slice inner and transpose
##[t,u] = ode45 (@calc_ut, [0 10], u0_slice);  %test solve on t usingode45, using dummy function as input
u_approx = half_step_methods(@calc_ut, t, u0_slice, h, 1);
##plot(x(2:end-1),u); %final t plot for checking
##size(u)
u_exact = sin(x)*exp(-T) + sin(9*x)*exp(-81*T);
##norm(u(end,:) - u_exact(2:end-1)) %check the final t of u_approx and u_exact
disp("||u_approx(T,x) - u_exact(T,x)|| = ")
norm(u_approx - u_exact(2:end-1)) %check the final t of u_approx and u_exact
disp(" ")
% (iii) finding k:
k_array = zeros(length(N), 3); %(elem N, method)
for m=1:2
  for it=1:length(N)
    prev_error = Inf;
    k_largest = 1;
    for k=5:15
      k
      h = 2^(-k); %2^(-k)
      disp(["N = ",num2str(N(it))])
      t = linspace(0, 10, T/h + 1);
      dx = mesh_size = L/N(it);
      x = -L:mesh_size:L;
      len = length(x);
      ##x = linspace(-L, L, N(it)+1);
      ##dx = x(2) - x(1); %sample any 2 points, probably should be mesh size?
      dx2 = dx^2;
      global A; % for fun input
      A = sparse( eye(len-2)*(-2/dx2) + diag(ones(len-3,1), 1)/dx2 + diag(ones(len-3,1), -1)/dx2 ); %u_xx coeff matrix finite diff
      u0 = sin(x) + sin(9*x); %initial condition
      ##plot(x, u0); %check the init cond
      ##figure();
      u0_slice = u0(2:end-1)'; % slice inner and transpose
      ##[t,u] = ode45 (@calc_ut, [0 10], u0_slice);  %test solve on t usingode45, using dummy function as input
      u_approx = half_step_methods(@calc_ut, t, u0_slice, h, m);
      ##plot(x(2:end-1),u); %final t plot for checking
      ##size(u)
      u_exact = sin(x)*exp(-T) + sin(9*x)*exp(-81*T);
      ##norm(u(end,:) - u_exact(2:end-1)) %check the final t of u_approx and u_exact
      disp("||u_approx(T,x) - u_exact(T,x)||_inf = ")
      curr_error = norm(u_approx - u_exact(2:end-1), Inf) %check the final t of u_approx and u_exact
      if prev_error < 1.2*curr_error
        k_largest = k
        k_array(it, m) = k_largest;
        break
      endif
      prev_error = curr_error;
    endfor
  endfor
endfor
disp("k values:")
disp(k_array)

%(iv):
for m=1:2
  for it=1:length(N)
    k = k_array(it, m);
    %if k was not found:
    if k == 0
      k = 5;
    endif
    h = 2^(-k); %2^(-k)
    t = linspace(0, 10, T/h + 1);
    dx = mesh_size = L/N(it);
    x = -L:mesh_size:L;
    len = length(x);
    ##x = linspace(-L, L, N(it)+1);
    ##dx = x(2) - x(1); %sample any 2 points, probably should be mesh size?
    dx2 = dx^2;
    global A; % for fun input
    A = sparse( eye(len-2)*(-2/dx2) + diag(ones(len-3,1), 1)/dx2 + diag(ones(len-3,1), -1)/dx2 ); %u_xx coeff matrix finite diff
    u0 = x - pi*sign(x); %initial condition
    ##plot(x, u0); %check the init cond
    ##figure();
    u0_slice = u0(2:end-1)'; % slice inner and transpose
    ##[t,u] = ode45 (@calc_ut, [0 10], u0_slice);  %test solve on t usingode45, using dummy function as input
    u_approx = half_step_methods(@calc_ut, t, u0_slice, h, m);
    ##plot(x(2:end-1),u); %final t plot for checking
    ##size(u)
    u_exact = sin(x)*exp(-T) + sin(9*x)*exp(-81*T);
    ##norm(u(end,:) - u_exact(2:end-1)) %check the final t of u_approx and u_exact
    disp(["||u_approx(T,x) - u_exact(T,x)||_inf, (m, N, k)= (",num2str(m),",",num2str(N(it)),",",num2str(k),") :"])
    error = norm(u_approx - u_exact(2:end-1), Inf)
  endfor
endfor
