%E30
h = [0.1 1e-2 1e-3]
N = 1.5./h

for it=1:length(h)
  disp(["h = ",num2str(h(it))]);
  ym = zeros(N(it)+1, 4); #y(:,1)=exact, y(:,2)=euler, y(:,3)=first half, y(:,4)=second half, y(:,5)=runge kutta 
  ym(1,:) = 1;
  t = linspace(0, 1.5, N(it)+1);
  #exact:
  for i=1:length(t)
    ym(i,1) = sqrt(2*t(i)+1);
  endfor
  for i=1:N(it)
    #euler:
    ym(i+1,2) = ym(i,2)+h(it)*(ym(i,2)-(2*t(i)/ym(i,2)));
    
    #1st half step:
    ky1 = 
    kz1 =
    ky2 =  
    ym(i+1,3) = ym(i,3)+h(it)*ky2;
    #2nd half step:
    ym(i+1,4) = ym(i,4)+h(it)*(ym(i,4)-(2*t(i)/ym(i,4)));
    
    ky1 = dy(i,2);
    kz1 = -101*dy(i,2) - 100*ym(i,3); 
    ky2 = dy(i,2)+h(it)*kz1;
    ym(i+1,3) = ym(i,3) + 0.5*h(it)*(ky1 + ky2);
    
  endfor
  if it == 1
    disp("[y_exact, y_euler, y_2, y_3] = ");
    disp(ym);
  else
    plot(t,ym(:,1),"r", t,ym(:,2),"g", t,ym(:,3),"b");
    title(["h = ",num2str(h(it))]); xlabel('t'); ylabel('y'); legend({'y exact','y euler','y 2halfstep'},'Location','northeast');
    figure()
  endif  
endfor