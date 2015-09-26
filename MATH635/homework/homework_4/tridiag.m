function T = tridiag(n)
% Creates a random tridiagonal symmetric matrix of dimension nxn.
%
% Create two random vectors, one of length n, main_vector, and one of 
% length n-1, off_vector. Create three diagonal matrices using these
% vectors as the diagonal. Use main_vector to create diagonal matrix and
% off_vector to create 2 diagonal matrice one with the off_vector as the 
% main diagonal offset by -1 and one with the off_vector as the main 
% diagonal offset by 1.
% 
% Returns the sum of these matrices. 

main_vector = randn(n,1);
off_vector = randn(n-1,1);

main_diag = diag(main_vector);
sub_diag = diag(off_vector, -1);
sup_diag = diag(off_vector, 1);

T = main_diag + sub_diag + sup_diag;

end
