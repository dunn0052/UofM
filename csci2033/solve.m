function x = solve(A, b)
augmented_matrix = [A b];
R = my_rref(augmented_matrix);
x = R(:, end);
<<<<<<< HEAD
end
=======
end
>>>>>>> 881c89f72921d4108a9b924b49a2f370cb0861e7
