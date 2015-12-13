function b = column_vector(phi, interval, n, basis_type)
% Compute the column vector for the system to find the approximation
% to the solution of the differential equation y'' - y = -x with boundary
% conditions y(0) = y(1) = 0

if strcmp(basis_type, 'trig')
    b = feval(@(x) (-1).^x ./ (x.*pi), 1:n)';
elseif strcmp(basis_type, 'hat')
    b = feval(@(x) -x ./ ((n + 1).^2), 1:n)';
else
    syms x;

    b = [];

    for i=1:n
        b = [b; int(-x*phi(x, i), x, interval(1), interval(2))];    
    end
end
end
