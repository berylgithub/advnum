format short

% E61(i):
filename = "mm/jgl009.mtx" % small example
[rows, cols, entries, rep, field, symm] = mminfo(filename) % the metadata
[A, rows, cols, entries] = mmread(filename); % the entries
disp(A);

% E61(ii):
filenames = ["mm/bcspwr01.mtx"; "mm/can___24.mtx"; "mm/fidapm05.mtx";
            "mm/tols90.mtx"; "mm/qc324.mtx"; "mm/memplus.mtx"; "mm/saylr3.mtx"];
for i=1:length(filenames)
  [rows, cols, entries, rep, field, symm] = mminfo(filenames(i,:));
  A = mmread(filenames(i,:));
  nz(1) = nnz(A);
  subplot(2,3,1);
  spy(A);
  title(filenames(i,:));
  xlabel(["Nonzeros = ",num2str(nz(1))]);

  % Column-Permutation:
  tic;
  r = colperm(A);
  nz(2) = nnz(A(r,r));
  runtime(1) = toc;
  subplot(2,3,2);
  spy(A(r,r));
  title(['Column-Permutation of ', filenames(i,:)])
  xlabel(["Nonzeros = ",num2str(nz(2)), "; runtime = ",num2str(runtime(1)),"s"]);

  % Minimum-Degree:
  tic;
  r = amd(A);
  runtime(2) = toc;
  nz(3) = nnz(A(r,r));
  subplot(2,3,3);
  spy(A(r,r));
  title(['Minimum-Degree of ', filenames(i,:)])
  xlabel(["Nonzeros = ",num2str(nz(3)), "; runtime = ",num2str(runtime(2)),"s"]);

  % Cuthill-McKee:
  tic;
  r = symrcm(A);
  runtime(3) = toc;
  nz(4) = nnz(A(r,r));
  subplot(2,3,4);
  spy(A(r,r));
  title(['Cuthill-McKee of ', filenames(i,:)])
  xlabel(["Nonzeros = ",num2str(nz(4)), "; runtime = ",num2str(runtime(3)),"s"]);

  %plot runtime
  subplot(2,3,5);
  labels = {'Column-Permutation', 'Min Degree', 'Cuthill-McKee'};
  bar(runtime);
  title(filenames(i,:));
  ylabel('Runtime');
  set(gca,'xticklabel',labels)
  
  %plot nz
  subplot(2,3,6);
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