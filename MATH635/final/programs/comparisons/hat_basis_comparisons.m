addpath(genpath('../'))

clear all;

nodes = 0:0.001:1;

points = [0.25, 0.5, 0.75];
interval = [0, 1];
solution = exact_solution();
basis = @hat_basis;
basis_prime = @hat_basis_derivative;
basis_type = 'hat';

% Compute table of values 
for i=2:4
    y_n = approximation(basis, basis_prime, interval, i, basis_type);
    fprintf('n = %i', i)
    exacts = [];
    approxs = [];
    differs = [];
    errors = [];
    for j=1:length(points)
        point = points(j);
        exact = solution(point);
        approx = double(y_n(point));
        difference = abs(exact - approx);
        rel_error = (100 * difference) / abs(exact);
        
        fprintf('\n')
        exacts = [exacts; exact];
        approxs = [approxs; approx];
        differs = [differs; difference];
        errors = [errors; rel_error];
    end
    disp([' y |', ' y_n |', ' abs(y - y_n) |', ' rel_err_% '])
    disp([exacts, approxs, differs, errors])
end

% Plot approximations.
for i=2:4
    subplot(3, 1, i-1)
    
    y_n = approximation(basis, basis_prime, interval, i, basis_type);
    
    subplot_title = sprintf('Exact solution y vs Approximation y%i', i);
    approximations = [];
    for j=1:length(nodes)
        node = nodes(j);
        approximations = [approximations, y_n(node)];
    end
    plot(nodes, feval(solution, nodes), nodes, approximations)
    legend('Exact Solution', 'Approximation (hat functions)')
    title(subplot_title)
end
