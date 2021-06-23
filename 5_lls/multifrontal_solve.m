function x = multifrontal_solve(A, b, e, Cv_list, separator_idx_list)
  D_list = {};
  R_list = {};
  U_list = {};
  y = b;
  x = zeros(length(y),1);
  for v=e
    % assemble Fv:
    J = cell2mat(Cv_list{v}(1:separator_idx_list(v)));
  ##  J = [1,3] %for tests
    K = cell2mat(Cv_list{v}(separator_idx_list(v)+1:end));
    A_JJ = A(J,:)(:,J);
    A_JK = A(J,:)(:,K);
    A_KJ = A(K,:)(:,J);
    A_KK = A(K,:)(:,K);
  ##  F = [A_JJ A_JK; A_KJ A_KK]
  ##  D = inverse(F(J,:)(:,J)) % Dv
  ##  R = D*F(J,:)(:,K) % error out of bound, probably indexing mistake
    D = inverse(A_JJ); % temporary easy way to inverse, due to A_JJ size is small
    R = D*A_JK;
    U = A_KK - A_KJ*R;
    D_list{end+1} = D;
    R_list{end+1} = R;
    U_list{end+1} = U;
  endfor
  % forward elimination:
  for v=e
    J = cell2mat(Cv_list{v}(1:separator_idx_list(v)));
    K = cell2mat(Cv_list{v}(separator_idx_list(v)+1:end));
    y(K) -= R_list{v}'*y(J);
  endfor
  % backsubstition:
  for v=flip(e) % reverse e's sequence
    J = cell2mat(Cv_list{v}(1:separator_idx_list(v)));
    K = cell2mat(Cv_list{v}(separator_idx_list(v)+1:end));
    x(J) = D_list{v}*y(J) - R_list{v}*x(K);
  endfor
endfunction