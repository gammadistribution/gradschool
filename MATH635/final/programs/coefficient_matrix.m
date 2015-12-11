function A = coefficient_matrix(basis, basis_prime, interval, n)
% Create the coefficient matrix used to find the approximation using the 
% method of finite elements to the solution of the differential equation 
% y'' - y = -x with boundary conditions y(0) = y(1) = 0. Note that this 
% matrix is symmetric so  that only half of the entries need to be computed.

A = [];

for i=1:n
    for j=1:i
        entry = system_coefficient(basis, basis_prime, i, j, interval);
        A(i, j) = entry;
        if i ~= j
            A(j, i) = entry;
        end
    end
end

end
