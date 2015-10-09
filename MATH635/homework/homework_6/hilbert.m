function H = hilbert(n)
% Create Hilbert matrix of dimension n. Each entry (i, j) in the Hilbert
% matrix is 1 / (i + j - 1).

H = double.empty;

for i = 1:n
    for j = 1:i
        entry = 1 / (i + j - 1);
        H(i,j) = entry;
        % Since Hilbert matrices are symmetric the entry in i,j is the same
        % as the entry in j,i. Only assign to this entry if we are off the
        % main diagonal so as to not perform n unnecessary operations
        if i ~= j
            H(j,i) = entry;
        end
    end
end