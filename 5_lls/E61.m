format short

% E61(i):
filename = "mm/jgl009.mtx" % small example
[rows, cols, entries, rep, field, symm] = mminfo(filename) % the metadata
[A, rows, cols, entries] = mmread(filename); % the entries
disp(A);

% E61(ii):
filenames = ["mm/bcspwr01.mtx"; "mm/can___24.mtx"; "mm/fidapm05.mtx"; 
"mm/tols90.mtx"; "mm/qc324.mtx"; "mm/memplus.mtx"; "mm/saylr3.mtx"];
%
plt_r = 3;
plt_c = 4;
for i=1:length(filenames)
  [rows, cols, entries, rep, field, symm] = mminfo(filenames(i,:));
  A = mmread(filenames(i,:));
  [L,U,P,Q] = lu(A);
  nz(1) = nnz(L);
  subplot(plt_r,plt_c,1);
  spy(A);
  title(filenames(i,:));
  subplot(plt_r,plt_c,5); #factor
  spy(L);
  xlabel(["Nonzeros = ",num2str(nz(1))]);
  title(['L (LU) - factor of ', filenames(i,:)])
  
  % Column-Permutation:
  tic;
  r = colperm(A);
  runtime(1) = toc;
  [L,U,P,Q] = lu(A(r,r));
  nz(2) = nnz(L);
  subplot(plt_r,plt_c,2);
  spy(A(r,r));
  title(['Column-Permutation of ', filenames(i,:)])
  xlabel(["runtime = ",num2str(runtime(1)),"s"]);
  subplot(plt_r,plt_c,6); #factor
  spy(L);
  xlabel(["Nonzeros = ",num2str(nz(2))]);
  title(['L of Colperm of ', filenames(i,:)])
  
  % Minimum-Degree:
  tic;
  r = amd(A);
  runtime(2) = toc;
  [L,U,P,Q] = lu(A(r,r));
  nz(3) = nnz(L);
  subplot(plt_r,plt_c,3);
  spy(A(r,r));
  title(['Minimum-Degree of ', filenames(i,:)])
  xlabel(["runtime = ",num2str(runtime(2)),"s"]);
  subplot(plt_r,plt_c,7); #factor
  spy(L);
  xlabel(["Nonzeros = ",num2str(nz(3))]);
  title(['L of MinDegree of ', filenames(i,:)])
  
  % Cuthill-McKee:
  tic;
  r = symrcm(A);
  runtime(3) = toc;
  [L,U,P,Q] = lu(A(r,r));
  nz(4) = nnz(L);
  subplot(plt_r,plt_c,4);
  spy(A(r,r));
  title(['Cuthill-McKee of ', filenames(i,:)])
  xlabel(["runtime = ",num2str(runtime(3)),"s"]);
  subplot(plt_r,plt_c,8); #factor
  spy(L);
  xlabel(["Nonzeros = ",num2str(nz(4))]);
  title(['L of CM of ', filenames(i,:)])
  
  %plot runtime
  subplot(plt_r,plt_c,9);
  labels = {'Column-Permutation', 'Min Degree', 'Cuthill-McKee'};
  bar(runtime);
  title(filenames(i,:));
  ylabel('Runtime');
  set(gca,'xticklabel',labels)

  %plot nz
  subplot(plt_r,plt_c,10);
  labels = {'Default', 'Column-Permutation', 'Min Degree', 'Cuthill-McKee'};
  bar(nz);
  title(filenames(i,:));
  ylabel('Nonzeros');
  set(gca,'xticklabel',labels)
  figure();

% Nested Dissection: no ND implementation in Octave
##r = dissect(A);
##spy(A(r,r));
##title(['Nested Dissection of ', filename])
##xlabel(["Nonzeros = ",num2str(nnz(A(r,r)))]);
##figure();
endfor