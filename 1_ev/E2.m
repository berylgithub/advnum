memsize = 8*(10^9); #8GB of RAM
max_l = floor(log2(sqrt(memsize/8)));
for l=1:max_l
  n = 2^l;
  v = (1:n)';
  B = repmat(v,1,n);

  A = B + B';
  tic;lam=eig(A);tim(l,1)=toc;
  
  A = B + B'.^2;
  tic;lam=eig(A);tim(l,2)=toc;
  
  A = sqrt((B.*B') + B + 1);
  tic;lam=eig(A);tim(l,3)=toc;
  
  A = -max(3 - abs(B - B'), 0);
  tic;lam=eig(A);tim(l,4)=toc;

  A = -max(3 - abs(B - B'), 0);
  A = sparse(A)
  tic;lam=eigs(A);tim(l,5)=toc;
end
loglog(tim);
legend({'c1','c2','c3','c4','c5'}, 'location', 'northwest')
