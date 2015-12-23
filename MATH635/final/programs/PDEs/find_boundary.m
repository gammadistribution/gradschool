function [x, y] = find_boundary(region, portion)
% Express the boundaries of the triangle 'region' in terms of the variable 
% x. It is assumed that the the points of the region are ordered such that 
% x-coordinates are monotonically increasing. If the string 'portion' is
% 'l', then return the boundaries formed by the first and second points of
% the array 'region'. If the string 'portion' is 'r', then return the
% boundaries formed by the second and third points of the array 'region'.
% An error is raised if portion is any other object other than 'l' or 'r'.
% Return cells x and y containing boundaries ordered by increasing value.


% First boundary is the horizontal line along the top or bottom of the
% triangle. 
boundary_1 = line_equation(region(1,:), region(3,:));

if strcmp(portion, 'l')
    x = {region(1,1), region(2,1)};
    boundary_2 = line_equation(region(1,:), region(2,:));
elseif strcmp(portion, 'r')
    x = {region(2,1), region(3,1)};
    boundary_2 = line_equation(region(2,:), region(3,:));
else
    error('portion must be string "l" or string "r"')
end

% Check if boundary_2 is greater than horizontal line boundary_1.
if region(2,2) >= region(1,2)
    y = {boundary_1, boundary_2};
% If it isn't than boundary_2 is less than horizontal line boundary_1.
else
    y = {boundary_2, boundary_1};
end


end


function y = line_equation(p1, p2)
% Determine the equation of the line passing through the two points in 2D.


difference = p2 - p1;
slope = difference(2) / difference(1); x0 = p1(1); y0 = p1(2);

y = @(x) slope * (x - x0) + y0;


end
