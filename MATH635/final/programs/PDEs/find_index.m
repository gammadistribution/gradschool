function index = find_index(region, regions)
% Find the first index such that region is matched with an array found in
% regions.

for i=1:length(regions)
    if all(region == regions{i})
        index = i;
        return
    end
end