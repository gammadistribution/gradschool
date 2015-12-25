function bool = triangle_interior(region, coordinate)
% Return whether or not the coordinate is within the given triangular
% region. The barycentric coordinates of the triangle 'region' are the
% solution to the system Ax = b. Note that region is a 3x2 matrix where
% each row is the x-y coordinate of a vertex of the triangle. Similarly
% coordinate is a 1x2 matrix. Return 1 if coordinate is in region and 0
% otherwise.

A = [region'; 1, 1, 1];

b = [coordinate'; 1];

barycentric_coordinates = A \ b;

% If all coordinates are nonnegative then coordinate is within triangle.
if all([0;0;0] <= barycentric_coordinates)
    bool = 1;
else
    bool = 0;
end

end
