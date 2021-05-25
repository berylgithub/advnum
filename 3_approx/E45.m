format compact;
% E45(i):
##rng(1); % random seed, doesnt work in octave, only in matlab
N = 6
P = 1; Q=N;
z = linspace(0, 1, N);
##z = rand(N,1); %random data vector with length = N
disp("initial z vector data:")
disp(z);
T = 2
disp("");
z_prime = fftnum(N, T, P, Q, z);
disp("transformed z:")
disp(z_prime);

% inverse:
##z_inverse = fftnum(N, T, P, Q, z_prime)/N;
##disp("inverse z_prime:")
##disp(z_inverse);

% matlab fft for comparison:
##z_prime = fft(z);
##disp("transformed z:")
##disp(z_prime);
##z_inverse = fft(z_prime)/N; %inverse fft, fft(z_prime)/N
##disp(z_inverse);



% E45 (ii) & (iii):
p = primes(11);
len_k = 12;
err_vector = t_vector = n_vector = zeros(len_k*length(p));
iter = 1;
for k=1:len_k
  for i = p
    N = i^k;
    if N <= 1e5
      disp(N);
      n_vector(iter) = N;
      z = rand(N,1);
      tic;
      z_prime = fftnum(N, i, 1, N, z); % fft
      t_vector(iter) = toc;
      y = fftnum(N, i, 1, N, z_prime); % inverse fft
      err_vector(iter) = norm(y-z)/norm(z);
      iter+=1;
    endif
  endfor
endfor

bool = n_vector > 0;
t_vector = t_vector(bool); n_vector = n_vector(bool); err_vector = err_vector(bool); % slice
[out,idx] = sort(n_vector);
t_vector = t_vector(idx); n_vector = n_vector(idx); err_vector = err_vector(idx); % sort

plot(n_vector, t_vector);
xlabel('N'); ylabel("t");
figure();
plot(n_vector, err_vector);
xlabel('N'); ylabel("error");