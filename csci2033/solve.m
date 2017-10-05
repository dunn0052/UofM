function x = solve(A, b)
augmented_matrix = [A b];
R = my_rref(augmented_matrix);
x = R(:, end);
end