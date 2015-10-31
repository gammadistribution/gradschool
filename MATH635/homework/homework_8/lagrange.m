function polynomial = lagrange(nodes, func)


    function basis_polynomial = basis_polynomial(i, nodes)
        for j=1:length(nodes)
        basis_polynomial = i
    end

% Evaluate the function at the nodes to get the points to interpolate.
y = arrayfun(func, nodes);

for i=1:length(nodes)
    node = nodes(i)
end

end