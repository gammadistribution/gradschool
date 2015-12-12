function phi_prime = linear_basis_derivative(x, j)
% Returns evaluation of the j-th basis function's derivative for the linear 
% case at x. Note that j must be a positive integer greater than or equal 
% to 1. We restrict x to be in the interval [0, 1].

phi_prime = j*(x.^(j-1))*(1-x).^j - j*(x.^j)*(1-x).^(j-1);

end
