#E7.(iii), using "first companion linearization":
#Q(lambda) = lambda^2*M + lambda*C + K
#L(lambda) = lambda*[M 0; 0 I_n] + [C K; -I_n 0]
syms lambda;
M = [-10 2 -1; 2 -11 2; -1 2 -12]; #corresponds to lambda^2
C = [1 2 1; 2 1 2; 1 2 0]; #to lambda
K = [10 2 -1; 2 9 3; -1 3 10]; #as constant
n = length(M);
zero_mat = zeros(n);
I = eye(n);
L = lambda*[M zero_mat; zero_mat I] + [C K; -I zero_mat];
disp(L);
det_L = det(L);
disp(det_L);
eigv = solve(det_L, lambda);
disp(eigv);
