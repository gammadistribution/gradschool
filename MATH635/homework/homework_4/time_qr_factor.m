function time_qr_factor(dimension, iterations)
% Time function qr_factor for square tri-diagonal matrices. 
%
% For each integer dim from 1 to dimension, iterate from 1 to iterations,
% creating a tridiagonal matrix of dimension dim and timing custom 
% qr_factor vs qr for created matrix. Display number of times custom
% factorization beat matlab's function for each matrix dimension.

for dim = 1:dimension
    counter = 0;
    for iteration = 1:iterations
        T = tridiag(dim);
        tic
        [Q_1,R_1] = qr_factor(T);
        time_1 = toc;

        tic
        [Q_2,R_2] = qr(T);
        time_2 = toc;

        if time_1 < time_2
            counter = counter + 1;
        end
    end
    fprintf('For dimension = %i, custom factorization faster in %i out of %i iterations.\n', dim, counter, iterations)
end
