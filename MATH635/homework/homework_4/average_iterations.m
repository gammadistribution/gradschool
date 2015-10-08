% Find using the below parameters the average number of iterations to
% converge to true eigenvalues with the defined precision threshold.

% number of trials
cycles = 1000;
% matrix dimension for tridiag function
matrix_dim = 4;
% epsilon used in sequence to check convergence
precision = 1e-10;
% if iterations exceeds this number sequence is assumed to diverge.
threshold = 10000;

iterations = double.empty;

for i=1:cycles
    iterations = [iterations, eig_values_iteration_count(tridiag(matrix_dim), @qr_factor, precision, threshold, false)];
end

avg_iterations = mean(iterations)

% On my first run avg_iterations is 187 for precision 1e-10
