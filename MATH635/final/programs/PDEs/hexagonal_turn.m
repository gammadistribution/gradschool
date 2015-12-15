function center = hexagonal_center(j)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

if j == 0
    center = [0, 0];
elseif j == 1
    center = [-2, 0];
elseif j == 2
    center = [-1, 1];
elseif j == 3
    center = [1, 1];
elseif j == 4
    center = [2, 0];
elseif j == 5
    center = [1, -1];
elseif j == 6
    center = [-1, -1];
end

end

