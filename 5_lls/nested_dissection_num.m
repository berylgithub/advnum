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
  % uses queue so the larger separators are placed last
  % min_v :=  minimum vertices for tolerance, automatically place the vertices first if |G|<=min_v
  G = M; %copy the sparse matrix
  [i,j,s] = find(G);
  vertices = unique(i)'; %vertices tracker
  v_counter = length(vertices);% vertices' count tracker
  que = {vertices}; %init que for recursive procedure
  e_order = zeros(1, length(vertices)); % elimination order vector
  e_pointer = 1; e_pointer_f = length(e_order); %last and first indexer
  
  
  while length(que) > 0
    % start the nested dissection:
    if v_counter == 0 % halt if all of the vertices are deleted
      break
    endif
    if nnz(G)== 0 % if only disconnected vertices left, place all first:
      for k=1:length(vertices)
        if vertices(k) ~= -1
          vert = vertices(k);
          e_order(e_pointer_f) = vert;
          e_pointer_f -= 1;
          G(vert,:) = G(:,vert) = 0; vertices(vert) = -1; v_counter -=1;
        endif
      endfor
    endif
    
    if v_counter == 0 % halt if all of the vertices are deleted
      break
    endif
    [distances, prev] = dijkstra_num(G, que{1}(1)); % get the earliest labelled vertex
    % accumulate distances by neighbourhood (neighbourhood count):
    sliced_distance = distances(find(distances~=Inf));
    max_d = max(sliced_distance);
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
    [_, sep_nb] = max(nbs_dist_count);
    separators = {};
    for i=1:length(distances)
      if distances(i) == sep_nb
        separators{end+1} = i;
      endif
    endfor
    
    % add the separators to the elimination vector and remove it from graph (place last):
    for k=1:length(separators)
      v = separators{k};
      e_order(e_pointer) = v;
      e_pointer += 1;
      G(v,:) = G(:,v) = 0; vertices(v) = -1; v_counter -=1;
    endfor
    
    % get the connected components:
    [i,j,s] = find(G);
    v = unique(i);
    if length(v) == 0 %if only disconnected vertices left, place all first:
      for k=1:length(vertices)
        if vertices(k) ~= -1
          vert = vertices(k);
          e_order(e_pointer_f) = vert;
          e_pointer_f -= 1;
          G(vert,:) = G(:,vert) = 0; vertices(vert) = -1; v_counter -=1;
        endif
      endfor
      break
    endif
    [d, p] = dijkstra_num(G, v(1));
    first_cc = find(d ~= Inf)'; % first conn comp
    separators = cell2mat(separators);
    temp_cc = zeros(1, length(first_cc) + length(separators));
    temp_cc(1, 1:length(first_cc)) = first_cc;
    temp_cc(1, 1+length(first_cc):length(first_cc)+length(separators)) = separators;
    sec_cc = setdiff(que{end}, temp_cc); %second conn comp
    que(1) = [];% deque
    % add to que if the vertices left > min_v, otherwise put everything in the elimination vector:
    if length(first_cc) > min_v
      que{end+1} = first_cc; % enqueue
    else
      for k=1:length(first_cc) %place first (actually last, but will be flipped in the end)
        v = first_cc(k);
        e_order(e_pointer_f) = v;
        e_pointer_f -= 1;
        G(v,:) = G(:,v) = 0; vertices(v) = -1; v_counter -=1;
      endfor
    endif
    if length(sec_cc) > min_v
      que{end+1} = sec_cc; % enqueue
    else
      for k=1:length(sec_cc) %place first
        v = sec_cc(k);
        e_order(e_pointer_f) = v;
        e_pointer_f -= 1;
        G(v,:) = G(:,v) = 0; vertices(v) = -1; v_counter -=1;
      endfor
    endif
  endwhile
  
  
  %..... at the end, reverse the e_order
  e_order = flip(e_order);
endfunction
