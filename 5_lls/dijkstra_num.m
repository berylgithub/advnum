## Copyright (C) 2021 Beryl Aribowo
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} dijkstra_num (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Beryl Aribowo <beryl.aribowo@univie.ac.at>
## Created: 2021-07-07

function [distances, prev] = dijkstra_num (G, source)
  %dijkstra for sparse (recommended, but also possible for dense) matrix G
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
