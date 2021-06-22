% E67, Compute the Cv and fills from an elimination ordering of the grid representation of
% the 5 point Laplacian discretization
rows = 4
cols = 3
M = grid_generator(rows, cols); % generate rows*cols grid in sparse matrix format
disp("Grid (in sparse mat) = ");
disp(M);
##disp(full(M)); %test the grid generator
e = [1:rows*cols] % generate the elimination ordering, can be any permuted vector of the nodes
% Eliminate the nodes based on the elimination ordering, while generating the list of Cv:
[fill_count, Cv_list, separator_idx_list] = eliminate_var(M, e);
v = 4
disp("Cv = ")
disp(Cv_list{v}) % the Cv:= Jv U Kv or (Jv|Kv) where |:= separator index
Jv = Cv_list{v}(1:separator_idx_list(v))
Kv = Cv_list{v}(separator_idx_list(v)+1:end)
disp(["fill count = ",num2str(fill_count)]) % total fills generated

% Using reordering algorithm:
M = grid_generator(rows, cols);
e = amd(M)
[fill_count, Cv_list, separator_idx_list] = eliminate_var(M, e);
v = 4
disp("Cv = ")
disp(Cv_list{v}) % the Cv:= Jv U Kv or (Jv|Kv) where |:= separator index
Jv = Cv_list{v}(1:separator_idx_list(v))
Kv = Cv_list{v}(separator_idx_list(v)+1:end)
disp(["fill count = ",num2str(fill_count)]) % total fills generated

% Larger grid:
rows = 32
cols = 32
M = grid_generator(rows, cols);
e = amd(M);
[fill_count, Cv_list, separator_idx_list] = eliminate_var(M, e);
v = 100
disp("Cv = ")
disp(Cv_list{v}) % the Cv:= Jv U Kv or (Jv|Kv) where |:= separator index
Jv = Cv_list{v}(1:separator_idx_list(v))
Kv = Cv_list{v}(separator_idx_list(v)+1:end)
disp(["fill count = ",num2str(fill_count)]) % total fills generated