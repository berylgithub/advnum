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
## @deftypefn {} {@var{retval} =} calc_ut (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Saint8312 <Saint8312@SAINT8312-RYZEN>
## Created: 2021-07-05

function dudt = calc_ut (t, u0)
  global A
  dudt = A*u0;% c = 1 is ommited
endfunction
