function phi_prime = linear_basis_derivative(j)
% Returns a function representing the derivatives of our basis functions 
% for the linear case. Note that j must be a positive integer greater than 
% or equal to 1.

phi_prime = @(x) j*(x.^(j-1))*(1-x).^j - j*(x.^j)*(1-x).^(j-1)

end

