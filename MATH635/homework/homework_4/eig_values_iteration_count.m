function iterations = eig_values_iteration_count(T, qr_factor_method, precision, threshold, verbose)
% Return the number of iterations in the QR method it takes for the sequence
% to converge to the true eigenvalues of the matrix T.

matrix = T;
[Q,R] = qr_factor_method(matrix);    
former_matrix = matrix;
matrix = R*Q;

% iterations counter
i = 0;

% Find the true eigenvalues of the matrix using builtin function
true_eig_values = sort(eig(matrix));

% Check if sorted diagonal converges to sorted actual eigen values
while norm((sort(diag(matrix)) - true_eig_values),1) >= precision
    [Q,R] = qr_factor_method(matrix);    
    former_matrix = matrix;    
    matrix = R*Q;
    i = i+1;
    % If the sequence appears to diverge, i.e. doesn't converge after 
    % threshold iterations, break off
    if i >= threshold
        if verbose
            fprintf('Sequence diverged after %i iterations.\n', i)
        end
        iterations = i;
        break
    end
end

if verbose
    fprintf('Sequence converged after %i iterations.\n', i)
end

iterations = i;

end