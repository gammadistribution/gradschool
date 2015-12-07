function y = solution(interval, n)

coefficients = solve_system(interval, n);

syms x;

basis = [];
for i=1:n
    basis = [basis;sin(i*pi*x);];
end


y = x + sum(coefficients.*basis);

end

