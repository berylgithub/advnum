#heun
y = 7;
dy = 13;
t = 0;
h = 0.25;
for i=1:3
  ky1 = dy
  kz1 = (11*e^-t - 5*y - 3*dy)/2
  ky2 = dy+h*kz1
  kz2 = (11*e^-(t+h) - 5*(y+h*ky1) - 3*(dy+h*kz1))/2
  yl = y + 0.5*h*(ky1 + ky2)
  dyl = dy + 0.5*h*(kz1 + kz2)
  disp("")
  y = yl;
  dy = dyl;
  t = t+h;
 endfor