%E32
h = [1/8 1/64 1/256]
N = 3./h

for it=1:length(h)
##  it=2;
  disp(["h = ",num2str(h(it))]);
  dy = zeros(N(it)+1, 3);
  ym = zeros(N(it)+1, 4); #y(:,1)=exact, y(:,2)=euler, y(:,3)=second half, y(:,4)=third half 
  ym(1,:) = 3;
  dy(1,:) = -102;
  t = linspace(0, 3, N(it)+1);
  #exact:
  for i=1:length(t)
    ym(i,1) = 2*(e^(-t(i)))+e^(-100*t(i));
  endfor
  for i=1:N(it)
    #euler:
    ym(i+1,2) = ym(i,2)+h(it)*dy(i,1);
    dy(i+1,1) = dy(i,1)+h(it)*(-101*dy(i,1)-100*ym(i,2));
    
    #2nd half step:
    ky1 = dy(i,2);
    kz1 = -101*dy(i,2) - 100*ym(i,3); 
    ky2 = dy(i,2)+h(it)*kz1;
    kz2 = -101*(dy(i,2)+h(it)*kz1) - 100*(ym(i,3)+h(it)*ky1);
    ym(i+1,3) = ym(i,3) + 0.5*h(it)*(ky1 + ky2);
    dy(i+1,2) = dy(i,2) + 0.5*h(it)*(kz1 + kz2);
    
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