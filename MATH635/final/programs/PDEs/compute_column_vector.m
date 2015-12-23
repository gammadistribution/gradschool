function b = compute_column_vector(f)
% Compute the column vector in the system of equations used to solve
% Laplace equation. The function f is the function in the nonhomogeneous
% differential equation - \triangle u = f(x).

b = [];
for i=0:6
    entry = compute_column_vector_entry(i, f);
    b = [b; entry];
end

end


function entry = compute_column_vector_entry(i, f)
% Compute the i-th entry of the column vector. The function f is used to
% calculate the integrals that determine this column vector.

[regions, planes] = hexagonal_basis(i);

integrals = [];
syms x y;
for j=1:length(regions)
    region = regions{j};
    z = planes{j};

    % Find boundary of left right triangle and boundary of right right 
    % triangle formed by splitting triangle region in half.
    [x_1, y_1] = find_boundary(region, 'l');
    [x_2, y_2] = find_boundary(region, 'r');
    
    % Find integral over region as sum of integrals over left right
    % triangle and right right triangle.
    integral_1 = int(int(z(x, y) * f(x), y, y_1{1}(x), y_1{2}(x)), x, x_1{1}, x_1{2});
    integral_2 = int(int(z(x, y) * f(x), y, y_2{1}(x), y_2{2}(x)), x, x_2{1}, x_2{2});
    
    integrals = [integrals, integral_1 + integral_2];
end

entry = sum(integrals);

end

