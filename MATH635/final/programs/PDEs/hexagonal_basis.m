function [regions, planes] = hexagonal_basis(j)
% Returns the piecewise function representing the hexagonal basis function
% used in approximating the solution to the LaPlace partial differential
% equation. Returns the cell array regions representing the points defining
% the polygon for a particular piece of the basis and the cell array 
% planes containing the equations of the plane associated to the regions. 
% The parameter j represents the j-th basis function defined by the j+1-th
% node in basis_nodes.dat

nodes = dlmread('basis_nodes.dat', ' ', 1, 0);

basis_node = nodes(j + 1,:);

regions = cell(1, 6);
planes = cell(1, 6);

% Iterate through the outer basis nodes and add them to the basis_node to
% get the points defining the triangles of the j+1-th basis function and
% the plane associated to the region.
for i=2:length(nodes)
    v_1 = nodes(i,:);
    if i == length(nodes)
        v_2 = nodes(2,:);
    else
        v_2 = nodes(i + 1,:);
    end
    point_1 = basis_node + v_1;
    point_2 = basis_node + v_2;

    % Sort the points so that they are easily compared and can readily
    % interpret boundaries of regions.
    regions{i-1} = sortrows([point_1; point_2; basis_node]);
    planes{i-1} = plane_equation([point_1, 0], [point_2, 0], [basis_node, 1]);
end

end
