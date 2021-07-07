## Copyright (C) 2021 Beryl Aribowo
## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} dijkstra_num (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Beryl Aribowo <beryl.aribowo@univie.ac.at>
## Created: 2021-07-07

function [distances, prev] = dijkstra_num (G, source)
  %dijkstra for sparse (recommended, but also possible for dense) symmetric matrix G
  % reference: en.wikipedia.org/wiki/Dijkstra%27s_algorithm
  [i,j,s] = find(G); 
  vertices = unique(i); % get the vertices
  n = length(vertices);
  Q = vertices'; % vertex set
  distances = Inf(n, 1); % distance vector
  distances(source) = 0;
  prev = NaN(n, 1); % previous nodes of distances(k) from source
  sum_halt = n; %if = 0 then halt
  
  % the algorithm:
  while sum_halt > 0
    
    % look for min distance:
    min = Inf;
    for k=Q
      if k ~= -1 %if not deleted
        if distances(k) <= min
          min = distances(k);
          u = k; %get the min vertex
        endif
      endif
    endfor
    
    % remove u from Q:
    Q(u) = -1;
    sum_halt -= 1;
    
    % find undeleted neighbours v of u:
    [_, vs, _] = find(G(u,:));
    for v=vs
      if Q(v) ~= -1
        alt = distances(u) + G(u,v);
        if alt < distances(v)
          distances(v) = alt;
          prev(v) = u;
        endif
      endif
    endfor
    
  endwhile
endfunction
