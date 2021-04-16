function [x, lambda] = inverse_iteration(A, B, x, sigma, el)
  for i=1:el
    xl = (A - sigma*B)\(B*x);
    if ~all(isfinite(xl))
      break;
    end
    x = xl/norm(xl); #eigvec
    lambda = (x'*A*x)/(x'*B*x); #rayleigh quotient for eigval
    disp(["iter = ",num2str(i), ":"]);
    disp("eigvec = ");
    disp(x)
    disp(["eigval = ", num2str(lambda)]);
    disp("\n");
  end
endfunction