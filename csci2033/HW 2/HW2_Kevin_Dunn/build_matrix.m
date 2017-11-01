function A = build_matrix()
e8 = eye(8);
A = eye(8);
for i = 1:8
    A(1:8,i) = get_forces(e8(1:8,i));
end

