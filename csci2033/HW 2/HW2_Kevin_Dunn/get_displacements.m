function d = get_displacements(f,L,U,P)
g = P*f;
y = L\g;
d = U\y;
A