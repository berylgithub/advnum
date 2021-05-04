%E27 (i) and (ii):
h = 0.1;
t = 11;
x = y = dx = dy = zeros(t,1);
##x = linspace(1,0,11)
x(1) = 1; dx(1) = 2; dy(1) = 1; #velocity of river y'(0) = 1, velocity of dog x'(o) = 2; dog's starting point = (1,0)

%trajectory using Euler's method:
for i=1:t-1
  x(i+1) = x(i) + h*((-2*x(i))/sqrt(x(i)^2 + y(i)^2));
  y(i+1) = y(i) + h*((1-2*y(i))/sqrt(x(i)^2 - y(i)^2));
endfor

disp(x);
disp("");
disp(y);

plot(x, y);
xlabel("x");
ylabel("y");

%===================================================
%E27 (iii):
%Newton's method to determine t where x(t) $\approx$ 0:
tk = 0;
xk = 1;
yk = 0;
sp_tk = inf; #tk with smallest positive xk
iternum = inf; #num of iter (time unit) to reach smallest positive xt
for i=1:t
  tl = tk - (xk/((-2*xk)/sqrt(xk^2 + yk^2))) #t_k+1 = t_k - (x(t)/x'(t))
  xprev = xk;
  N = 10;
  h = (tl-tk)/N;
  #approximate next x and y (of t_{k+1} from newton\s method):
  for j=1:N
    xl = xk + h*((-2*xk)/sqrt(xk^2 + yk^2));
    yl = yk + h*((1-2*yk)/sqrt(xk^2 - yk^2));
    xk = xl;
    yk = yl;
  endfor
  if (xk < xprev) && (xk>0) #check for smallest && positive x_{t+1}
    sp_tk = tk;
    iternum = i;
  endif
  tk = tl;
endfor
disp(["amount of time for the dog to reach its master = ", num2str(sp_tk)]);
##disp(["amount of time for the dog to reach its master = ", num2str(iternum), " unit of time"])