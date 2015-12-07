function coefficients = solve_system(interval, n)

A = coefficient_matrix(interval, n);

syms x;

b = [];
for i=1:n
    b(i) = -int(((x+2)/(exp(1) - 1) + x.^2 + 2*x - 1)*sin(i*pi*x), x, interval(1), interval(2));
end
b = b';

coefficients = A \ b;

end
