%E25(iii):
format compact;
format long;
tj = 1;

% exact sol:
yx = exp(2*tj);
disp(["exact: y(tj) = ",num2str(yx)]);

% Approx sol:
h = 0.1
yp = (1+2*h)^(tj/h);
disp(["approx: y_j = ",num2str(yp)]);

% local error on tj = 1:
err_threshold = 0.5e-4
for i=1:10
  delta = norm(yp - yx);
  disp(["iter = ",num2str(i), "; h = ",num2str(h),"; delta = ", num2str(delta)]);
  if delta <= err_threshold
    break
  endif
  h = h*0.1;
  yp = (1+2*h)^(tj/h);
endfor

disp(["final value of h = ",num2str(h)])

%E25(iv):
% using h from prev steps.
y = 1;
for i=1:10
  y = y + h*(2*y)
  endfor