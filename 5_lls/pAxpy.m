function b = pAxpy(A, B, x, y)
  b = B\((A*x) + y);
endfunction