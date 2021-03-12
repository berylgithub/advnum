#E3:
u = ones(10,1); #for dense 1-x10 A
n = length(u);
I = eye(n);
gamma = 2/(u'*u);
S = I - gamma*u*u';

#transformation B = SAS^-1:
A = triu(ones(10)); #example A
A(1:n+1:end) = (1:10);
B = A - (gamma*u)*(u'*A);
#B = B*S;
B = B - (B*(gamma*u))*u'


#equal set of eigvalues between A and B:
disp("A = ")
disp(num2str(round(A), 3))
disp("B = ")
disp(num2str(round(B), 3))
disp("eig(A) = ")
disp(eig(A))
disp("eig(B) = ")
disp(round(eig(B)))
