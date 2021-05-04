%E28(i):
y = 3.84*1e8;
dy = 0; #initial speed at the time of stopping
g = 9.81;
R = 6.36*1e6;
N = 1e6;
h = abs(R-y)/N;
limit_iter = inf; #to store i where y_i > R && y_i closest to R;
y_prev = y_next = inf; #to store the value of y_i < R and y_i > R which are the closest to R;
for i=1:N
  %%storing mechanism:
  y_prev = y;
  
  y1 = y + h*dy;
  dy1 = dy + h*(-g*(R^2)/(y^2));
  y = y1;
  dy = dy1;
  disp(["y = ",num2str(y)])
  
  %%if y < R, stop:
  if y < R
    limit_iter = i; #store max iter when y > R  
    y_next = y;
    break
  endif

endfor
disp(["total iterations happened in euler's method = ",num2str(limit_iter)]);
disp(["yprev for bisection = ", num2str(y_prev)]);
disp(["ynext for bisection = ", num2str(y_next)]);
disp("Bisection: ")
%%bisection:
max_iter = 0;
for i=1:100
  yc = (y_prev+y_next)/2
  if abs(yc-R) < 1e3 #threshold
    max_iter = i;
    break
  endif
  if (y_prev > R) && (yc < R)
    y_next = yc;
  else
    y_prev = yc;
  endif
endfor
disp(["y close to R found in iter = ",num2str(max_iter)])