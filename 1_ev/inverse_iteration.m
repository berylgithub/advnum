function [x, sigma] = inverse_iteration(A, B, x, sigma, l)
  for i=1:l
%    x = (gamma*inv(A - sigma*B)*(B*x)); #eigvec
    x = (inv(A - sigma*B)*(B*x))/norm(inv(A - sigma*B)*(B*x)); #eigvec
    sigma = (x'*A*x)/(x'*B*x); #rayleigh quotient for eigval
    disp(["iter = ",num2str(i), ":"]);
    disp("eigvec = ");
    disp(x)
    disp(["eigval = ", num2str(sigma)]);
    disp("\n");
%    disp(["l = ", num2str(l), ", eigenvector = ", num2str(x)]);
%    disp(["l = ", num2str(l), ", eigenvalue = ",num2str(sigma)])
  end
endfunction