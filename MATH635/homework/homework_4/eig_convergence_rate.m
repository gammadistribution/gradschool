convergence = [];

for i = 1:100
    T = tridiag(4);
    iterations = eig_values_convergence(T, @qr_factor, eps, 100, false);
    convergence = [convergence, iterations];
end

convergence