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
    yk = ym(i,3)+0.5*h(it)*(ym(i,3)-(2*t(i)/ym(i,3)));
    fyk = yk-(2*t(i)/yk);
    ym(i+1,3) = ym(i,3)+h(it)*fyk;
    
    #2nd half step:
    fy = ym(i,4)-(2*t(i)/ym(i,4));
    yk = ym(i,4)+h(it)*fy;
    fyk = yk-(2*t(i)/yk);
    ym(i+1,4) = ym(i,4)+0.5*h(it)*(fy+fyk);
    
    #runge kutta:
    
    
  endfor

  plot(t,ym(:,1),"r", t,ym(:,2),"g", t,ym(:,3),"b", t,ym(:,4),"c");
  title(["h = ",num2str(h(it))]); xlabel('t'); ylabel('y'); legend({'y exact','y euler','y 1halfstep', 'y 2halfstep'},'Location','northeast');
  figure()
    
endfor