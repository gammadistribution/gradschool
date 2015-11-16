function n = convergence_threshold(solution, scheme, func, interval, eta, epsilon, threshold)
% Find the number of n subintervals such that the norm of the difference 
% between the solution arrived at by the passed numerical scheme and the
% actual solution is less than the passed threshold. 
%
% The function solution is a function that represents the exact solution
% to the given differential equation. The function scheme is a numerical
% scheme that is used to compute an approximation to the exact solution.
% The function func is the differential equation to be solved. The array 
% interval is the interval on which to compute the solution. eta is the
% value of the initial condition and epsilon is the perturbation of the
% initial condition.
%
% Returns the number n of subintervals needed for the scheme to approximate
% the exact solution within the given threshold.
if func2str(scheme) == 'ode23_method'
    n = 2;
else
    if func2str(scheme) == 'ode45_method' 
        n = 2;
    else
        n = 1;
    end
end

[t, u] = scheme(func, interval, eta, n, epsilon);
[t_h, u_h] = solution(interval, n, epsilon);

while norm(u_h - u, inf) >= threshold
    n = n + 1;
    [t, u] = scheme(func, interval, eta, n, epsilon);
    [t_h, u_h] = solution(interval, n, epsilon);
end

end
