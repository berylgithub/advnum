% E52
N = [10 100 1000];
method = [1 2 3];
##c=1
L = pi;
T = 10;
it = 1; %element of N
dx = mesh_size = L/N(it);
x = -L:mesh_size:L;
len = length(x);
##x = linspace(-L, L, N(it)+1);
##dx = x(2) - x(1); %sample any 2 points, probably should be mesh size?
dx2 = dx^2;
global A; % for fun input
A = sparse( eye(len-2)*(-2/dx2) + diag(ones(len-3,1), 1)/dx2 + diag(ones(len-3,1), -1)/dx2 ); %u_xx coeff matrix finite diff
u0 = sin(x) + sin(9*x) %initial condition
u0_slice = u0(2:end-1)'; % slice inner and transpose
plot(x, u0); %check the init cond
figure();
##f_ut = @(t, u) A*b;
##ut = f_ut([0, 1],u0)
[t,u] = ode45 (@calc_ut, [0, 10], u0_slice);  %test with ode45, using dummy function as input
plot(x(2:end-1)',u')
u_exact = sin(x)*exp(-T) + sin(9*x)*exp(-81*T)
u(end,:) %result is always dim-2
u0
norm(u(end,:) - u_exact(2:end-1))