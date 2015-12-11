function phi = linear_basis(j)
% Returns a function representing our basis functions for the linear 
% case. Note that j must be a positive integer greater than or equal to 1.

phi = @(x) x.^j * (1-x).^j;

end
