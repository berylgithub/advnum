function [fill_count, Cv_list, separator_idx_list] = eliminate_var(M, e)
  % Eliminate the nodes based on the elimination ordering, while generating the list of Cv:
  % M := sparse matrix
  % e := a vector of elmination ordering
  fill_count = 0;
  Cv_list = {};
  separator_idx_list = ones(length(e)); % index of "|" in (J|K), used during absorption (generating supernodes)
  for Jv=e
    % Find Kv := v's neighbours:
    [i,j,s] = find(M);
    Kv = {Jv};
    for idx=1:length(i);
      if i(idx) == Jv
        Kv{end+1} = j(idx);
      endif
    endfor
    % Create Cv := Jv U Kv:
    Cv_list{end+1} = Kv;
    % Calculate the fills:
    Kv_vec = cell2mat(Kv)(2:end);
    if length(Kv_vec) > 1
      fill_idxes = nchoosek(Kv_vec, 2); % generate the fills' combination
      if length(fill_idxes) > 1 % if the combination is not empty
        for k=1:length(fill_idxes(:,1))
          if M(fill_idxes(k,1), fill_idxes(k,2)) == 0 % if no edge
            M(fill_idxes(k,1), fill_idxes(k,2)) = M(fill_idxes(k,2), fill_idxes(k,1)) = 1; % add edge
            fill_count += 1; % add fill
          endif
        endfor
      endif
      M(Jv,:) = M(:,Jv) = 0; % remove/eliminate node:
    endif
  endfor
endfunction