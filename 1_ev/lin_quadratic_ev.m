function [V, D] = lin_quadratic_ev(A, B, C, sigma)
  n = length(A);
  I = eye(n);
  A_sigma = [sigma*I I; A-(sigma*B)-((sigma^2)*C) -B-(sigma*C)];
  [V, D] = eig(A_sigma);
 endfunction