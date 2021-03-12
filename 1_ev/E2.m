#exercise ch 1:
max_l = 20;
#E2 (i):
for l=1:max_l;
  n=2^l;
  A = zeros(n,n);
  for i=1:n;
    for k=1:n;
      A(i,k) = i+k;
    end
  end
  tic;lam=eig(A);tim(l,1)=toc;
  disp(["l =",num2str(l)," done"])
end
disp("case 1 done!")

#E2 (ii):
for l=1:max_l;
  n=2^l;
  A = zeros(n,n);
  for i=1:n
    for k=1:n
      A(i,k) = i+(k^2);
    end
  end
  tic;lam=eig(A);tim(l,2)=toc;
  disp(["l =",num2str(l)," done"])

end
disp("case 2 done!")


#E2 (iii):
for l=1:max_l;
  n=2^l;
  A = zeros(n,n);
  for i=1:n
    for k=1:n
      A(i,k) = sqrt(i*k + i + 1);
    end
  end
  tic;lam=eig(A);tim(l,3)=toc;
  disp(["l =",num2str(l)," done"])
end
disp("case 3 done!")

#E2 (iv):
for l=1:max_l
  n=2^l;
  A = zeros(n,n);
  for i=1:n
    for k=1:n
      A(i,k) = -max(3-abs(i-k), 0);
    end
  end
  tic;lam=eig(A);tim(l,4)=toc;
  disp(["l =",num2str(l)," done"])
end
disp("case 4 done!")

#E2 (v):
for l=1:max_l
  A = zeros(n,n);
  for i=1:n
    for k=1:n
      A(i,k) = -max(3-abs(i-k), 0);
    end
  end
  A = sparse(A);
  tic;lam=eig(A);tim(l,5)=toc;
  disp(["l =",num2str(l)," done"])
end
disp("case 5 done!")

loglog(tim);