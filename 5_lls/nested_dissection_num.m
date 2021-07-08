## Copyright (C) 2021 Beryl Aribowo
## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} nested_dissection_num (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Beryl Aribowo <beryl.aribowo@univie.ac.at>
## Created: 2021-07-07

function e_order = nested_dissection_num (M, min_v)
  % create nested dissection ordering of a sparse symmetric matrix (laplace matrix)
  % always start from the earliest labelled vertex
  G = M; %copy the sparse matrix
  [i,j,s] = find(G);
  vertices = unique(i)';
  stack = {vertices} %init stack for recursive procedure
  e_order = zeros(1, length(vertices));
  e_pointer = 1; e_pointer_f = length(e_order);
  [distances, prev] = dijkstra_num(G, vertices(1));
  % accumulate distances by neighbourhood (neighbourhood count):
  max_d = max(distances);
  nbs_dist = 1:1:max_d;
  nbs_dist_count = zeros(1, length(nbs_dist));
  for d=nbs_dist
    count = 0;
    for i=1:length(distances)
      if distances(i) == d
        count += 1;
      endif
    endfor
    nbs_dist_count(d) = count;
  endfor
  % set the neighbours which has the max num of vertices as separators:
  [_, sep_nb] = max(nbs_dist_count)
  separators = {};
  for i=1:length(distances)
    if distances(i) == sep_nb
      separators{end+1} = i;
    endif
  endfor
  % add the separators to the elimination vector and remove it from graph:
  for k=1:length(separators)
    v = separators{k};
    e_order(e_pointer) = v;
    e_pointer += 1;
    G(v,:) = G(:,v) = 0;
  endfor
  % get the connected components:
  separators
  [i,j,s] = find(G);
  v = unique(i)
  [d, p] = dijkstra_num(G, v(1));
  first_cc = find(d ~= Inf)' % first conn comp
  separators = cell2mat(separators);
  temp_cc = zeros(1, length(first_cc) + length(separators));
  temp_cc(1, 1:length(first_cc)) = first_cc;
  temp_cc(1, 1+length(first_cc):length(first_cc)+length(separators)) = separators;
  sec_cc = setdiff(stack{end}, temp_cc) %second conn comp
  % add to stack if the vertices left > min_v, otherwise put everything in the elimination vector:
  if length(first_cc) > min_v
    stack{end+1} = first_cc;
  else
    for k=1:length(first_cc) %place first
      v = first_cc(k);
      e_order(e_pointer_f) = v;
      e_pointer_f -= 1;
      G(v,:) = G(:,v) = 0;
    endfor
  endif
  if length(sec_cc) > min_v
    stack{end+1} = sec_cc;
  else
    for k=1:length(sec_cc) %place first
      v = sec_cc(k);
      e_order(e_pointer_f) = v;
      e_pointer_f -= 1;
      G(v,:) = G(:,v) = 0;
    endfor
  endif
  
  
  %..... at the end, reverse the e_order
  e_order = flip(e_order)
  stack
endfunction
