function [Q, R] = qr_factor(T)
% Perform QR factorization of a square tridiagonal matrix T.

l_T = length(T);
Q = double.empty;
R_diag = double.empty;

% Create unitary matrix Q.
for i = 1:l_T
    a_i = T(:,i);
    
    Q_j = double.empty;

    for j = 1:i -1
        coefficient = 0;
        for k = i-1:i+1
            if k < l_T
                coefficient = coefficient + Q(k,j)*T(k,i);
            end
        end
        coefficient = sum(coefficient);
        Q_j = [Q_j,coefficient.*Q(:,j)];
        % If matrix was not tridiagonal use the below.
        % Q_j = [Q_j,(Q(:,j)'*T(:,i)).*Q(:,j)];
    end
    
    if isempty(Q_j)
        Q_j = zeros(length(T), 1);
    else
        Q_j = sum(Q_j, 2);
    end
    
    Q = [Q,(a_i - Q_j)./norm(a_i - Q_j)];
    R_diag = [R_diag,norm(a_i - Q_j)];
end

R = diag(R_diag);
l_R = length(R);

% Create upper triangular matrix R.
for i = 1:l_R
    for j = i+1:i+2 
        if j <= l_R
            R(i,j) = Q(:,i)'*T(:,j);
        end
    end
end

end
