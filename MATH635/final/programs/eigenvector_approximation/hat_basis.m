function phi = hat_basis(x, j, n)
% Returns evaluation of the j-th basis functions for the hat basis
% case at x. Note that j must be a positive integer greater than or equal 
% to 1. We restrict x to be in the interval [0, pi].

% Knowing that the interval is always [0, pi] for this problem, we set a =
% 0, and see that x_j = j*h = j*pi/(n+1)

h = pi / (n + 1);

if (j - 1) * h <= x && x <= j * h
    phi = (x - (j - 1)*h ) / h;
elseif j * h <= x && x <= (j + 1) * h
    phi = -(x - (j + 1)*h ) / h;
else
    phi = 0;
end
