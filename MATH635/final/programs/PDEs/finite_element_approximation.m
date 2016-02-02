function u_7 = finite_element_approximation(f)
% Computes the approximation u_7 to the Laplace equation 
% -\triangle u = f(x).

A = compute_stiffness_matrix();
b = compute_column_vector(f);

% These coefficients determine the approximation.
coefficients = A \ b;

% Need to create a function that will determine position of point x, y and
% then return evaluation of function at that point.

u_7 = @(x, y) evaluate_approximation(coefficients, [x, y]);

end


function evaluation = evaluate_approximation(coefficients, coordinate)
% Use the coefficients of the approximation function to provide the
% evaluation of the appproximation at the given coordinate. Each basis
% function consists of triangular regions. Find out whether or not
% coordinate is in a given triangular region. If it is, then evaluate the
% plane associated to the region at the coordinate and multiply times the
% coefficient associated to the basis. The sum of all such products is the
% evaluation of the approximation.

products = [];
for i=1:length(coefficients)
    [regions, planes] = hexagonal_basis(i-1);
    for j=1:length(regions)
        region = regions{j};
        if triangle_interior(region, coordinate)
            x_0 = coordinate(1);
            y_0 = coordinate(2);
            products = [products, coefficients(i) * planes{j}(x_0, y_0)];
        end
    end
end
    
evaluation = sum(products);
            
end