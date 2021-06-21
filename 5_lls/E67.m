% E67, Compute the minimum Cv and fills from an elimination ordering on a row*col grid
rows = 4;
cols = 3;
M = grid_generator(rows, cols); % generate rows*cols grid in sparse matrix format
##disp(M);
##disp(full(M)); %test the grid generator
e = [1:rows*cols] % generate the elimination ordering
% Eliminate the nodes based on the elimination ordering, while generating the list of Cv:
[fill_count, Cv_list] = eliminate_var(M, e);
##disp(Cv_list{2}{1,4});
disp(Cv_list)
disp(fill_count)
