%E68
rows = cols = 2.^[1:7] % dimensions

for i=1:length(rows)
  N = rows(i)*cols(i);
  A = grid_generator(rows(i), cols(i));
  A(1:size(A,1)+1:end) = -4; % only need to change the diag from grid representation
  b = linspace(0, 1, N)'; % any vector, for testing
  tic;
  x_direct = A\b; % direct solve
  runtime(i,1) = toc;
  
  % Multifrontal solution for sparse linear system:
  e = [1:N]; %elimination ordering
  A = grid_generator(rows(i), cols(i));
  [fill_count, Cv_list, separator_idx_list] = eliminate_var(A, e); % symbolic factorization
  A = grid_generator(rows(i), cols(i)); % regenerate sparse matrix
  A(1:size(A,1)+1:end) = -4; %the actual laplacian matrix
  %A = A(e,e); %re-order the matrix
  
  tic;
  x = multifrontal_solve(A, b, e, Cv_list, separator_idx_list);
  runtime(i,2) = toc;
  disp([num2str(i), "done !!"])
endfor
plot(runtime(:,1), "b-*-");
xlabel('dimension (2^{2x})')
ylabel('runtime')
hold on
plot(runtime(:,2), "r-+-");
legend('direct solve','multifrontal solve')