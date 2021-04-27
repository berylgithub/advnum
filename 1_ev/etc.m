A = [1 2; -1 -2];
Ap = (A+A')*0.5;
eig(A)
eig(Ap)