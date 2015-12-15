function phi = hexagonal_element(j)
% The variable j represents the j-th basis function and will vary between 
% 0 and 6.

center = [hexagonal_turn(j), 1];

vertices = [];
for i=1:6
    new_position_vector = hexagonal_turn(i);
    vertex = hexagonal_turn(j) + new_position_vector;
    vertices = [vertices; [vertex, 0]];
end
vertices
for j=1:6
    p1 = vertices(j,:);
    if j == 6
        p2 = vertices(1,:);
    else
        p2 = vertices((j + 1),:);
    end
    eqn = plane_equation(p1, p2, center);
end

end
