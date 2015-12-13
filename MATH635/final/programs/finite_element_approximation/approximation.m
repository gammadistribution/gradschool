function y_n = approximation(phi, phi_prime, interval, n, basis_type)
% Provide the approximation of the solution to the differential equation
% y'' - y = -x with boundary conditions y(0) = y(1) = 0. basis_type is
% either 'trig', 'hat', or any other string. In the first two cases, the
% coefficient matrix is constructed based off of the special structure of
% the basis functions provided as long as they match the basis_type.

b = column_vector(phi, interval, n, basis_type);

A = coefficient_matrix(phi, phi_prime, interval, n, basis_type);

coefficients = A \ b;

syms x;

if strcmp(basis_type, 'hat')
    y_n = @(x) hat_approximation(x, coefficients, phi, n);
else
    basis = [];
    for i=1:n
        basis = [basis; phi(x, i)];
    end
    y_n = @(x) sum(coefficients.*subs(basis, x));
end


end
