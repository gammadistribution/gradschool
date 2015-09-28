function time_eig_values(dimension, iterations, verbose)
% Time function eig_values for square tri-diagonal matrices. 
%
% For each integer dim from 1 to dimension, iterate from 1 to iterations,
% creating a tridiagonal matrix of dimension dim and timing custom 
% qr_factor vs qr for eigen value decomposition for created matrix. 
% Display number of times custom eig_values beat matlab's function for 
% each matrix dimension.

thresholds = [eps,1e-10,1e-8,1e-6];

for dim = 1:dimension
    counter = 0;
    for threshold = thresholds
        for iteration = 1:iterations
            T = tridiag(dim);
            tic
            evalues_1 = eig_values(T,@qr_factor,threshold,verbose);
            time_1 = toc;

            tic
            evalues_2 = eig(T);
            time_2 = toc;

            if time_1 < time_2
                counter = counter + 1;
            end
        end
        fprintf('For dimension = %i, threshold = %d, custom eigenvalue function faster in %i out of %i iterations.\n', dim, threshold, counter, iterations)
    end
end
