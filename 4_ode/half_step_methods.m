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
## @deftypefn {} {@var{retval} =} half_step_methods (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Saint8312 <Saint8312@SAINT8312-RYZEN>
## Created: 2021-07-05

function y = half_step_methods (fun, t, y0, h, method)
  %method = {1,2,3}
  %uses dummy t for fun input
  y = y0;
  if method == 1
    for i=t
      y_next = y + h*fun(0,(y + (h/2)*fun(0,y)));
      y = y_next;
    endfor
  elseif method == 2
    for i=t
      y_next = y + (h/2)*(fun(0, y) + fun(0, y + h*fun(0, y)));
      y = y_next;
    endfor
  endif
endfunction
