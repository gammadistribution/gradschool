function entry = compute_stiffness_entry(i, j)
% Compute the (i, j) element of the stiffness matrix A. We assume that 
% the matrix A is 0-indexed.

[regions_i, planes_i] = hexagonal_basis(i);
[regions_j, planes_j] = hexagonal_basis(j);

% Find the intersection of the regions for the two basis functions
intersection = find_intersection(regions_i, regions_j);

% If the intersection is empty, then the entry is 0.
if isempty(intersection)
    entry = 0;
    return
end

% Integral over entire region is sum of integrals over subregions.
syms x y;
for k=1:length(intersection)
    region = intersection{k};

    z_i = planes_i{find_index(region, regions_i)};
    z_j = planes_j{find_index(region, regions_j)};

    inner_product = sum(gradient(z_i(x, y)) .* gradient(z_j(x, y)));
    
    % find boundary using region then calculate integral using inner product.
end

end

