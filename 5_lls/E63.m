A = diag([0., 0.00025, 0.0005, 0.00075, 0.001, 10.0])
n = length(A);
%lanczos algo:
l = n #l shoud be arbitrary, in this case put l=n for symmetricity
beta = zeros(l);
q0 = 0;
q = ones(n, 1);
q = q/(norm(q)); %q1
%loop:

