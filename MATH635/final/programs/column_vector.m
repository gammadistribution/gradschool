function b = column_vector(phi, interval, n)
% Compute the column vector for the system to find the approximation
% to the solution of the differential equation y'' - y = -x with boundary
% conditions y(0) = y(1) = 0

syms x;

b = [];

for i=1:n
    b = [b; int(-x*phi(i), x, interval(1), interval(2))];
end

end
