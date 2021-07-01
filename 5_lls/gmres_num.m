function x = gmres_num(A, b, x0, k, dim, wfun)
  % GMRES:
  % init:
  H = zeros(k, k); %upper hessenberg
  Q = zeros(dim, k); %Q matrix
  x = zeros(dim, 1); %result matrix
  % algo
  r = b - wfun; 
  w = zeros(k, 1); %for backslash
  w(1) = norm(r);
  Q(:,1) = r/norm(r); %first q vec from residal
  for i=1:k
    %arnoldi:
    y = A*Q(:,i);
    for j=1:i
      H(j,i) = Q(:,j)'*y;
      y -= H(j,i)*Q(:,j);
    endfor
    H(i+1,i) = norm(y);
    if (H(i+1,i) != 0) && (i!=k)  %check if entry is 0 
      Q(:,i+1) = y/H(i+1,i);
    endif  
    z = H(1:k, 1:k)\w; %replace with function handle
    x = Q*z + x0; %approx result
  endfor
endfunction