function phi_prime = trigonometric_basis_derivative(x, j)
% Returns evaluation of the j-th basis function's derivative for the
% trigonmetric case at x. Note that j must be a positive integer greater 
% than or equal to 1. We restrict x to be in the interval [0, 1].

phi_prime = j*pi*cos(j*pi*x);

end
