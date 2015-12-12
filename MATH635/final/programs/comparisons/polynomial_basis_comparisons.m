addpath(genpath('../'))

clear all;

nodes = 0:0.001:1;

points = [0.25, 0.5, 0.75];
interval = [0, 1];
solution = exact_solution();
basis = @polynomial_basis;
basis_prime = @polynomial_basis_derivative;

% Compute table of values 
for i=2:4
    y_n = approximation(basis, basis_prime, interval, i);
    fprintf('n = %i', i)
    for j=1:length(points)
        point = points(j)
        exact = solution(point);
        approx = double(y_n(point));
        diff = abs(exact - approx);
        rel_error = (100 * diff) / abs(exact);
        
        fprintf('\n')
        disp(exact)
        disp(approx)
        disp(diff)
        disp(rel_error)
    end
end

% Plot approximations.
for i=2:4
    subplot(3, 1, i-1)
    
    y_n = approximation(basis, basis_prime, interval, i);

    subplot_title = sprintf('Exact solution y vs Approximation y%i', i);
    plot(nodes, feval(solution, nodes), nodes, subs(y_n, nodes))
    legend('Exact Solution', 'Approximation (\phi_k = x^k(1-x)^k)')
    title(subplot_title)
end
