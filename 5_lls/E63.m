A = diag([0., 0.00025, 0.0005, 0.00075, 0.001, 10.0])
n = length(A);
%lanczos algo:
el = n #el shoud be arbitrary
q = ones(n, 1);
q = q/(norm(q)) %q1
T = lanczos_num(A, q, el)
% check the eigenvalues:
v = eig(T)
disp("|eig(A) - eig(T)|:")
disp(abs(eig(A) - v)) % differences between eig(A) and eig(T)