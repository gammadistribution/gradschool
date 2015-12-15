function y_n = eigenvector_approximation(phi, n)
% Provide the approximation of the solution to the differential equation
% y'' + y = 0 with boundary conditions y(0) = y(pi) = 0. 

h = pi / (n+1);

main_diagonal = repelem(2/h, n);
off_diagonal = repelem(-1/h, n - 1);
A_1 = diag(main_diagonal) + diag(off_diagonal, -1) + diag(off_diagonal, 1);

main_diagonal = repelem(2*h/3, n);
off_diagonal = repelem(h/6, n - 1);
M = diag(main_diagonal) + diag(off_diagonal, -1) + diag(off_diagonal, 1);

% We are interested in the eigenvector associated to the lowest eigenvalue 
% (i.e. = 1)
[V, D] = eigs(A_1, M, 1, 'SM');

D = sort(diag(D));
% The coefficients are then the values of the eigenvector;
coefficients = V;

y_n = @(x) hat_approximation(x, coefficients, phi, n);

end