% Compute a table of threshold values for a variety of numerical schemes.

% Add all subdirectories of parent directory of current file.
addpath(genpath('./'))

% Define parameters for convergence_threshold.
interval = [0, 1];
eta = 1/3;
epsilon = 0.01;
thresholds = [0.1, 0.01, 0.001];

subintervals = [];
for threshold=1:length(thresholds)
    n = convergence_threshold(@solution, @eulers_method, @first_derivative, interval, eta, epsilon, thresholds(threshold));  
    subintervals = [subintervals, n];
end
