##E27 (i):
t = 11;
x = linspace(1,0,t);
y = zeros(t,1);
finish_x = 0; finish_y = 0; #master's coor
h = 0.1;
rspd = 1; dspd = 2; x(1) = 1; #speed of river = 1, speed of dog = 2; dog's starting point = (1,0)
for i=1:t
  dir_x = finish_x - x(i);
  dir_y = finish_y - y(i);
  move_x = dir_x*dspd;
  move_y = dir_y*dspd + rspd;
  x(i+1) = x(i) + h*move_x;
  y(i+1) = y(i) + h*move_y;
  
endfor

plot(x, y);
xlabel("x");
ylabel("y");
figure();


##E27 (ii):
N = 100;
h = 1/N;
x = y = zeros(N,1);
x(1) = 1;
for i=1:N-1
  x(i+1) = x(i) + h*(-2*x(i)/sqrt(x(i)^2 + y(i)^2));
  y(i+1) = y(i) + h*(1-2*y(i)/sqrt(x(i)^2 + y(i)^2));
endfor


plot(x, y);
xlabel("x");
ylabel("y");


%===================================================
##E27 (iii):
%Newton's method to determine t where x(t) $\approx$ 0:
maxiter = 20;
tk = 0;
xk = 1;
yk = 0;
sp_tk = inf; #tk with smallest positive xk
iternum = inf; #num of iter (time unit) to reach smallest positive xt
for i=1:maxiter
  tl = tk - (xk/(-2*xk/sqrt(xk^2 + yk^2))) #t_k+1 = t_k - (x(t)/x'(t))
  xprev = xk;
  N = 100;
  h = (tl-tk)/N;
  #approximate next x and y (of t_{k+1} from newton\s method):
  for j=1:N
    xl = xk + h*(-2*xk/sqrt(xk^2 + yk^2));
    yl = yk + h*(1-2*yk/sqrt(xk^2 + yk^2));
    xk = xl;
    yk = yl;
  endfor
  if (xk < xprev) && (xk>0) #check for smallest && positive x_{t+1}
    sp_tk = tl;
    iternum = i;
  endif
  tk = tl;
endfor
disp(["amount of time for the dog to reach its master = ", num2str(sp_tk)]);
##disp(["amount of time for the dog to reach its master = ", num2str(iternum), " unit of time"])