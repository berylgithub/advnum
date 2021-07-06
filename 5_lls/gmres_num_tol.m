## Copyright (C) 2021 Saint8312
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} gmres_num_tol (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Saint8312 <Saint8312@SAINT8312-RYZEN>
## Created: 2021-07-06

function [x, max_iter] = gmres_num_tol (A, b, x0, k, dim, wfun, tol, sol)
  % GMRES but with known sol for testing how many iters can the equation be solved
  % init:
  H = zeros(k, k); %upper hessenberg
  Q = zeros(dim, k); %Q matrix
  x = zeros(dim, 1); %result matrix
  max_iter = k; %default is the maximum iteration
  % algo
  r = b - wfun; 
  w = zeros(k, 1); %for backslash
  w(1) = norm(r);
  Q(:,1) = r/norm(r); %first q vec from residal
  for i=1:k
    %arnoldi:
    y = A*Q(:,i);
    for j=1:i
      H(j,i) = Q(:,j)'*y;
      y -= H(j,i)*Q(:,j);
    endfor
    H(i+1,i) = norm(y);
    if (H(i+1,i) != 0) && (i!=k)  %check if entry is 0 
      Q(:,i+1) = y/H(i+1,i);
    endif  
    z = H(1:k, 1:k)\w; %replace with function handle
    x = Q*z + x0; %approx result
    if norm(x - sol) <= tol % stopping cond
      max_iter = i;
      break
    endif
  endfor
endfunction
