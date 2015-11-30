function Y = linear_interpolation(t, u, x)

n = length(t)-1;

A = zeros(2*n, 2*n);
b = zeros(2*n, 1);

% Construct right-hand side vector 
b(1, 1) = u(1);
b(2*n, 1) = u(n+1);

for i=2:n
    b(2*i-2, 1) = u(i);
    b(2*i-1, 1) = u(i);
end

% Construct the coefficient matrix
for i=1:n
    A(2*i-1, 2*i-1) = t(i);
    A(2*i-1, 2*i) = 1;
    A(2*i, 2*i-1) = t(i+1);
    A(2*i, 2*i) = 1;
end

v = sparse(A)\b;

y = zeros(n-1, 1);

for i = 0:n-1
    if (t(i+1) <= x) && (x < t(i+2))
        y(i+1) = v(2*i+1)*x+v(2*i+2);
    end
end

Y = sum(y);

end