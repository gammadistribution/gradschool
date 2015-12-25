function u_7 = finite_element_approximation(f)
% Computes the approximation u_7 to the Laplace equation 
% -\triangle u = f(x).

A = compute_stiffness_matrix();
b = compute_column_vector(f);

% These coefficients determine the approximation.
coefficients = A \ b;

% Need to create a function that will determine position of point x, y and
% then return evaluation of function at that point.

end
