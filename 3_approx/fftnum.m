function z_prime = fftnum(z)
  % inputs:
  N = length(z);
  P = 1; Q = N;
  T = 2; #must look for the smallest factors of Q
  P_prime = P*T ; Q_prime = Q/T;
  z_prime = zeros(N,1);
  
  % check if T is a prime <= 31:
  if ~ismember(T, primes(31))
    disp("T is not a prime < 31, exiting function");
    return
  endif
  
  % algorithm:
  theta = 2*pi/P_prime;
  omega_star = cos(theta)+1i*sin(theta);
  for el = Q_prime:-1:1
    x=1;
    IQ = el+N; IQ_prime = el+Q;
    for k=P_prime:-1:1
      if IQ == el
        IQ = el+Q;
      endif
      x *= omega_star; IQ_prime -= Q_prime;
      if T == 2
        IQ -= Q_prime; f = z(IQ);
        IQ -= Q_prime; z_prime(IQ_prime) = x*f + z(IQ);
      else
        f = 0;
        for j=T:-1:1
          IQ -= Q_prime; f = x*f + z(IQ);
        endfor
        z_prime(IQ_prime) = f;
      endif      
    endfor
  endfor
end