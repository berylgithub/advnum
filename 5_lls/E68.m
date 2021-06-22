%E68
rows = 20
cols = 20
N = rows*cols;
A = grid_generator(rows, cols);
A(1:size(A,1)+1:end) = -4; % only need to change the diag from grid representation
b = linspace(0, 1, N)'; % any vector, for testing
x_direct = A\b % direct solve

% Multifrontal solution for sparse linear system:
e = [1:N] %elimination ordering
##e = amd(M)
A = grid_generator(rows, cols);
[fill_count, Cv_list, separator_idx_list] = eliminate_var(A, e); % symbolic factorization
A = grid_generator(rows, cols); % regenerate sparse matrix
A(1:size(A,1)+1:end) = -4; %the actual laplacian matrix
A = A(e,e); %re-order the matrix

D_list = {};
R_list = {};
U_list = {};
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
y = b;
x = zeros(length(y),1);
for v=e
  J = cell2mat(Cv_list{v}(1:separator_idx_list(v)));
  K = cell2mat(Cv_list{v}(separator_idx_list(v)+1:end));
  y(K) -= R_list{v}'*y(J);
endfor
% backsubstition:
for v=N:-1:1
  J = cell2mat(Cv_list{v}(1:separator_idx_list(v)));
  K = cell2mat(Cv_list{v}(separator_idx_list(v)+1:end));
  x(J) = D_list{v}*y(J) - R_list{v}*x(K);
endfor
x