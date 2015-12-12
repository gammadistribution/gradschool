function y_n = approximation(phi, phi_prime, interval, n)
% Provide the approximation of the solution to the differential equation
% y'' - y = -x with boundary conditions y(0) = y(1) = 0

b = column_vector(phi, interval, n);
A = coefficient_matrix(phi, phi_prime, interval, n);

coefficients = A \ b;

syms x;

basis = [];
for i=1:n
    basis = [basis; phi(x, i)];
end

y_n = @(x) sum(coefficients.*subs(basis, x));

end
