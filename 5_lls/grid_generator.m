function M = grid_generator(rows, cols)
  % generates row*col grid in sparse representation
  n = rows*cols;
  M = sparse(n,n);
  for r=1:rows
    for c=1:cols
      i = r*cols + c;
      % two inner diagonals:
      if c > 1 
        M(i-1,i) = M(i,i-1) = 1;
      endif
      % two outer diagonals:
      if r > 1 
        M(i-cols,i) = M(i,i-cols) = 1;
      endif
    endfor
  endfor
  slice_idx = cols+1; % index slicer
  M = M(slice_idx:end,slice_idx:end);
endfunction