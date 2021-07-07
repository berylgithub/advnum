## Copyright (C) 2021 Beryl Aribowo
## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} nested_dissection_num (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Beryl Aribowo <beryl.aribowo@univie.ac.at>
## Created: 2021-07-07

function e_order = nested_dissection_num (G, min_v)
  % create nested dissection ordering of a sparse symmetric matrix (laplace matrix)
  % always start from the earliest labelled vertex
  % 
  [i,j,s] = find(G);
  vertices = unique(i);
  e_order = zeros(1, length(vertices));
  e_pointer = 1;
  [distances, prev] = dijkstra_num(G, vertices(1));
  distances'
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
  nbs_dist_count
  [_, sep_nb] = max(nbs_dist_count)
  separators = {}
  for i=1:length(distances)
    if distances(i) == sep_nb
      separators{end+1} = i;
    endif
  endfor
  % add the separators to the elimination vector and remove it:
  G
  for i=1:length(separators)
    v = separators{i};
    e_order(e_pointer) = v;
    e_pointer += 1;
    G(v,:) = G(:,v) = 0;
  endfor
  G
  e_order
endfunction
