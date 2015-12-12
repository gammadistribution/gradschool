function solution = exact_solution()
% Returns evaluation of the exact solution of the differential
% equation y'' - y = x with boundary conditions y(0) = y(1) = 0.

solution = @(x) x + (exp(-x)*exp(1))/(exp(2) - 1) - (exp(1)*exp(x))/(exp(2) - 1);

end

