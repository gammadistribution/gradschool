function coefficient = system_coefficient(basis, basis_prime, i, j, interval)
% Compute the (i, j) entry of the coefficient matrix used to find 
% the coefficients of the linear combination of the approximation to the
% solution of the differential equation y'' - y = -x.
% Note that i and j must both be integers greater than or equal to 1.
% This uses the basis functions phi and the deriviate of the basis
% functions phi_prime to compute the integral needed for the coefficient
% matrix.

syms x;

phi_i = basis(i);
phi_j = basis(j);
phi_prime_i = basis_prime(i);
phi_prime_j = basis_prime(j);

coefficient = int(-phi_prime_j(x)*phi_prime_i(x) - phi_j(x)*phi_i(x), x, interval(1), interval(2));

end
