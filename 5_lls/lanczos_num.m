function T = lanczos_num(A, q, el)
  % A symmetric matrix
  % q initial guess
  n = length(A);
  alpha = beta = zeros(el, 1);
  w = A*q; % mat-vec mult
  alpha(1) = q'*w;
  bq = w - alpha(1)*q; %the last term = 0
  Q = zeros(n, el); %q matrix for orthogonalization
  Q(:,1) = q;
  %loop:
  for i=2:el
    q_prev = q; %store as previous q
    beta(i) = norm(bq);
    q = bq/beta(i);
    % orthogonalization:
    qsum = zeros(n, 1);
    for j=1:i-1
      qsum += (Q(:,j)'*q)*Q(:,j);
    endfor
    q -= qsum;
    q = q/norm(q);
    % end of orthogonalization
    Q(:,i) = q;
    w = A*q; % mat-vec mult
    alpha(i) = q'*w;
    bq = w - alpha(i)*q - beta(i)*q_prev;
  endfor
  T = diag(alpha) + diag(beta(2:el),1) + diag(beta(2:el),-1); %assemble T matrix
endfunction