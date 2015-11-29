format long;

addpath(genpath('../'))   

f = @(x) exp(0.5*x); 
c = 1;
initials = [0.5, 0.1];
interval = [0, 1];

perturbations = 0.1:0.2:0.7;

v = [];
for i=1:length(perturbations)
    perturbation = perturbations(i);
    disp(perturbation)
    
    diff = stability_test(f, c, initials, interval, perturbation);
    
    v = [v, diff];
end
    
v