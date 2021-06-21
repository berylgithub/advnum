% E67, Compute the minimum Cv and fills from an elimination ordering on a row*col grid
rows = 20
cols = 15
M = grid_generator(rows, cols); % generate rows*cols grid in sparse matrix format
disp("Grid (in sparse mat) = ");
disp(M);
##disp(full(M)); %test the grid generator
e = [1:rows*cols] % generate the elimination ordering, can be any permuted vector of the nodes
% Eliminate the nodes based on the elimination ordering, while generating the list of Cv:
[fill_count, Cv_list, separator_idx_list] = eliminate_var(M, e);
Jv = 4
disp("Cv = ")
disp(Cv_list{Jv}) % the Cv:= Jv U Kv or (Jv|Kv) where |:= separator index
Kv = Cv_list{Jv}(separator_idx_list(Jv)+1:end)
disp(["fill count = ",num2str(fill_count)]) % total fills generated

% Absorb nodes into supernodes (if any):
