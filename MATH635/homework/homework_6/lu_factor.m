function [L, U] = lu_factor(T)
% Perform LU factorization on tridiagonal matrix T.
%
% If T = [[d_1, c_1, 0,..., 0, 0],
%         [a_2, d_2, c_2,..., 0 , 0],
%         [0, a_3, d_3,..., 0, 0],
%          ...
%         [0, 0, 0,..., a_n, d_n]]
%
% then T = L*U where L is a lower unit triangular matrix and U is an upper 
% triangular matrix such that:
% L = [[1, 0, 0,...,0,0], 
%      [l_1,1,0,...,0,0], 
%      [0,l_2,1,...,0,0],
%       ...,
%      [0,0,0,...,l_n,1]]
% and
% U = [[u_1,c_1,0,...,0,0], 
%      [0,u_1,c_2,...,0,0], 
%      [0,0,u_3,...,0,0],
%       ...,
%      [0,0,0,...,0,u_n]]
% where l_i = a_i / u_(i - 1) and u_i = d_i - l_i * c_(i - 1).

n = length(T);

L = zeros(n);
U = zeros(n);

for i = 1:n
    % If we are on second row, then l_i is defined and get variables 
    % needed to calculate l_i. Otherwise set variables needed to calculate 
    % l_i such that l_i = 0.
    if i - 1 > 0
        c_i_minus_1 = T(i - 1, i);
        a_i = T(i, i - 1);
        u_i_minus_1 = u_i;
    else
        c_i_minus_1 = 0;
        a_i = 0;
        u_i_minus_1 = 1;
    end
    
    d_i = T(i, i);
    l_i = a_i / u_i_minus_1;
    u_i = d_i - l_i * c_i_minus_1;
    
    % If u_i is zero, then calculation of next l_i will return 0 if we
    % still have more l_i to calculate, so exit function as the LU 
    % factorization does not exist.
    if u_i == 0 && i ~= n
        return;
    end
    
    % Update off-diagonals of L and U if they exist.
    if i - 1 > 0
        L(i, i - 1) = l_i;
    end
    if i + 1 < n + 1
        U(i, i + 1) = T(i, i + 1);
    end
    
    % Update diagonals of matrices L and U.
    L(i, i) = 1;
    U(i, i) = u_i;
end

end