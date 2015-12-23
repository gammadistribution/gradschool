function A = compute_stiffness_matrix()
% Compute the stiffness matrix A used to solve Laplace equation for our
% specific example using 7 hexagonal basis functions.

A = [];
for i=0:6
    for j=0:6
        % MATLAB is 1-indexed but our basis functions and hence our
        % stiffness entries are 0-indexed. Accommodate this.
        entry = compute_stiffness_matrix_entry(i, j);
        A(i + 1, j + 1) = entry;
        % The matrix is symmetric
        if i ~= j
            A(j + 1, i + 1) = entry;
        end
    end
end

end         


function entry = compute_stiffness_matrix_entry(i, j)
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
integrals = [];

syms x y;
for k=1:length(intersection)
    region = intersection{k};

    z_i = planes_i{find_index(region, regions_i)};
    z_j = planes_j{find_index(region, regions_j)};
    
    inner_product = sum(gradient(z_i(x, y)) .* gradient(z_j(x, y)));
    
    % Find boundary of left right triangle and boundary of right right 
    % triangle formed by splitting triangle region in half.
    [x_1, y_1] = find_boundary(region, 'l');
    [x_2, y_2] = find_boundary(region, 'r');
   
    % Find integral over region as sum of integrals over left right
    % triangle and right right triangle.
    integral_1 = int(int(inner_product, y, y_1{1}(x), y_1{2}(x)), x, x_1{1}, x_1{2});
    integral_2 = int(int(inner_product, y, y_2{1}(x), y_2{2}(x)), x, x_2{1}, x_2{2});
    
    integrals = [integrals, integral_1 + integral_2];
end

entry = sum(integrals);

end


function intersection = find_intersection(regions_i, regions_j)
% Find the intersection between the regions contained in regions_i and
% regions_j. Returns cell array intersection containing regions in common.

intersection = {};
for ith=1:length(regions_i)
    region = regions_i{ith};
    for jth=1:length(regions_j)
        if all(region == regions_j{jth})
            intersection{end + 1} = region;
        end
    end
end

end


function index = find_index(region, regions)
% Find the first index such that region is matched with an array found in
% regions.

for i=1:length(regions)
    if all(region == regions{i})
        index = i;
        return
    end
end

end
