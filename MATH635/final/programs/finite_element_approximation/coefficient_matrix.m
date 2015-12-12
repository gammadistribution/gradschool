function A = coefficient_matrix(phi, phi_prime, interval, n, basis_type)
% Create the coefficient matrix used to find the approximation using the 
% method of finite elements to the solution of the differential equation 
% y'' - y = -x with boundary conditions y(0) = y(1) = 0. Note that this 
% matrix is symmetric so  that only half of the entries need to be computed.
% basis_type is a string consisting of either 'trig', 'hat', or any other
% string. In the case of the first two, the special structure of the basis
% functions is used to compute the coefficient matrix. Otherwise the
% general form is used.


if basis_type == 'trig'
    entry = @(j) (-j.^2*pi.^2 - 1)./2;
    A = diag(feval(entry, 1:n));
else
    A = [];
    for i=1:n
        for j=1:i
            entry = system_coefficient(phi, phi_prime, i, j, interval);
            A(i, j) = entry;
            if i ~= j
                A(j, i) = entry;
            end
        end
    end
end

end
