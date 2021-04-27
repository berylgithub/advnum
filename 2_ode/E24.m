format compact;
%E24(i):
disp("E24(i):")
h = 0.1;
u = 1; #u_0 = y_0 = 1
v = 0; #v_0 = y_0' = 0
for i=1:4
  u1 = u + h*v; #u_{k+1} = u_k + h*u_k', u_k' = v_k
  v1 = v + h*(-u); #v_{k+1} = v_k + h*v_k', v_k' = -u_k
  u = u1;
  v = v1;
  disp(["y_",num2str(i)," = ",num2str(u),"; y_",num2str(i),"' = ",num2str(v)]);
  endfor
disp("")

%E24(ii):
disp("E24(ii):")
u = 1; #u_0 = y_0 = 1
v = 0;#v_0 = y_0' = 0
for i=1:4
  u1 = u + h*v + 0.5*(h^2)*(-u);
  v1 = v + h*(-u);
  u = u1;
  v = v1;
  disp(["y_",num2str(i)," = ",num2str(u),"; y_",num2str(i),"' = ",num2str(v)]);
  endfor


##dt = 0.01;
##t = 0:dt:50;
##k=1;
##m=1;
##x0=3;
##v0=0;
##
##x = zeros(length(t), 1);
##v = zeros(length(t), 1);
##x(1) = x0;
##v(1) = v0;
##xs = x0;
##vs = v0;
##disp(length(t));
##for i = 1:length(t)-1
##  x(i+1) = x(i) + dt*v(i);
##  v(i+1) = v(i) - dt*k/m*x(i);
##  x1 = xs + dt*vs;
##  v1 = vs - dt*k/m*xs;
##  xs = x1;
##  vs = v1;
##end
##
##disp([num2str(x(length(t)))," ",num2str(v(length(t)))])
##disp([num2str(xs)," ",num2str(vs)])
##
##subplot(121);
##plot(t, x);
##xlabel("time");
##ylabel("displacement");
##
##subplot(122);
##plot(t, v);
##xlabel("time");
##ylabel("velocity");