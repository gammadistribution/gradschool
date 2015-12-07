function A = coefficient_matrix(interval, n)

A = [];
for i=1:n
    for j=1:n
        A(i, j) = system_coeff(i, j, interval);
    end
end


end