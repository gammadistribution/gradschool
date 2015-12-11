function y_n = approximation(phi, phi_prime, interval, n)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

b = column_vector(phi, interval, n);
A = coefficient_matrix(phi, phi_prime, interval, n)

coefficients = A \ b;

syms x;

basis = [];
for i=1:n
    phi_i = phi(i);
    basis = [basis; phi_i(x)];
end

y_n = @(x) sum(coefficients.*subs(basis, x));

end

