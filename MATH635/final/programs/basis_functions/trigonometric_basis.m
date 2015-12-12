function phi = trigonometric_basis(x, j)
% Returns evaluation of the j-th basis functions for the trigonmetric
% case at x. Note that j must be a positive integer greater than or equal 
% to 1. We restrict x to be in the interval [0, 1].

phi = sin(j*pi*x);

end
