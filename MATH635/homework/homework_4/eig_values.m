function evalues = eig_values(T, qr_factor_method, threshold, verbose)
% Return the eigenvalues of a matrix T using the passed qr_factor_method.

matrix = T;
[Q,R] = qr_factor_method(matrix);    
former_matrix = matrix;
matrix = R*Q;

i = 1;

while norm((diag(matrix) - diag(former_matrix)),1) >= threshold
    [Q,R] = qr_factor_method(matrix);    
    former_matrix = matrix;    
    matrix = R*Q;
    i = i+1;
    % If the sequence appears to diverge, break off
    if norm((diag(matrix) - diag(former_matrix)),1) >= 10000
        if verbose
            fprintf('Sequence diverged after %i iterations.\n', i)
        end
        evalues = NaN;
        break
    end
end

if verbose
    fprintf('Sequence converged after %i iterations.\n', i)
end
evalues = diag(matrix);

end