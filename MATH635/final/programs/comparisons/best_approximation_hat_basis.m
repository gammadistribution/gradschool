addpath(genpath('../'))

clear all;

points = [0.25, 0.5, 0.75];
interval = [0, 1];
y = exact_solution();
basis = @hat_basis;
basis_prime = @hat_basis_derivative;
basis_type = 'hat';

rel_error = @(exact, approx) 100 * abs(exact - approx) / abs(exact);

n = 2;
fprintf('n = %i',n)
y_n = approximation(basis, basis_prime, interval, n, basis_type);
errors = [];
for i=1:length(points)
    point = points(i);
    errors = [errors, rel_error(y(point), y_n(point))];
end

disp(errors)

% Make sure relative error % is less than 0.5%.
while norm(errors, inf) >= 0.5
    n = n + 1;
    fprintf('n = %i',n)
    errors = [];
    y_n = approximation(basis, basis_prime, interval, n, basis_type);
    for i=1:length(points)
        point = points(i);
        errors = [errors, rel_error(y(point), y_n(point))];
    end
    disp(errors)
end

