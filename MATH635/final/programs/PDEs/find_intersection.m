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
