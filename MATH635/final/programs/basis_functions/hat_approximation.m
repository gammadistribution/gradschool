function y_n = hat_approximation(x, coefficients, phi, n)
% Subroutine to calculate approximation of hat function. Computes for the
% passes x, the approximation using hat functions determined by passed
% coefficients.

basis = [];

for i=1:n
    basis = [basis; phi(x, i, n)];
end

y_n = sum(coefficients.*basis);

end
