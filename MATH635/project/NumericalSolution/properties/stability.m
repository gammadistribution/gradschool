format long;

addpath(genpath('../'))

f = @(x) x; 
c = 1;
initials = [0, 0];
interval = [0, 1];

perturbations = 0.1:0.1:0.5;

v = [];
for i=1:length(perturbations)
    perturbation = perturbations(i);
    diff = stability_test(f, c, initials, interval, perturbation);
    
    v = [v, diff]
end
    
    