dimensions = 60;
iterations = 100;
% sequence diverages after threshold iterations
threshold = 10000;

time_qr_factor(dimensions, iterations);
time_eig_values(dimensions, 5, threshold, false);
