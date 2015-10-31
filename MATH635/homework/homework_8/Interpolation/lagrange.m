function polynomial = lagrange(x, nodes, func)
% Creates the Lagrange interpolating polynomial of func at the given nodes 
% for the given x.

    function factors = basis_polynomial(x, nodes, i)
        % Create the basis polynomial for the i-th node.
        factors = [];
    
        for j=1:length(nodes)
            if j ~= i
                factor = (x - nodes(j)) / (nodes(i) - nodes(j));
                factors = [factors, factor];
            end
        end
    end

% Evaluate the function at the nodes to get the points to interpolate.
y = arrayfun(func, nodes);
polynomial = [];

% Evaluate the Lagrange polynomial.
for i=1:length(nodes)
    factors = prod(basis_polynomial(x, nodes, i));
    polynomial = [polynomial, y(i) * factors];
end

polynomial = sum(polynomial);

end