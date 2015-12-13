function phi = hat_basis(x, j, n)
% Returns evaluation of the j-th basis functions for the hat basis
% case at x. Note that j must be a positive integer greater than or equal 
% to 1. We restrict x to be in the interval [0, 1].

% Knowing that the interval is always [0, 1] for this problem, we set a =
% 0, and see that x_j = j*h = j/(n+1)

h = 1 / (n + 1);

if (j - 1) * h <= x && x <= j * h
    phi = (x - (j - 1)*h ) / h;
elseif j / (n + 1) <= x && x <= (j + 1) / (n + 1)
    phi = -(x - (j + 1)*h ) / h;
else
    phi = 0;
end
