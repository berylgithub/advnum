function [x_out y_out] = grid_refinement(x0, r, x, y, tri)
  %x0 = (x,y) coordinate arbitrary input
  %r = checking radius
  %x = vector of x coordinates for initial triangulation
  %y = vector of y coordinates for initial triangulation
  %tri = triangulation matrix, e.g., tri(1,:) = indexes of first triangle's edges
  len = length(x);
  disp(len)
##  idxes = zeros(len, 1);
  # check if any ||x0-(x[i],y[i])||<r :
  for i=1:len
    x_diff = x(1) - x(i);
    y_diff = y(1) - y(i);
    if norm([x_diff y_diff])<=r
      idxes(i) = i;
    endif
  endfor
  disp("idx")
  disp(idxes);
  # check for edges, if edge==true, create the midpoint:
  edge_check = nchoosek(idxes,2)# create combination of indexes for edge checking
  iter = 1;
  for i=1:length(edge_check)
    for j=1:length(tri(:,1))
      if all(ismember(edge_check(i,:),tri(j,:)))
        disp(edge_check(i,:));
        x_start = x(edge_check(i,1));
        x_end = x(edge_check(i,2));
        x_mid = (x_start + x_end)/2;
        y_start = y(edge_check(i,1));
        y_end = y(edge_check(i,2));
        y_mid = (y_start + y_end)/2;
        new_x(iter) = x_mid;
        new_y(iter) = y_mid;
        disp([num2str(x_mid)," ",num2str(y_mid)]);
        iter += 1;
        break;
      endif
    endfor
  endfor
  x_out = [x new_x]; % concat
  y_out = [y new_y];

  
  
end