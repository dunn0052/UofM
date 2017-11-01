function d = get_displacement(f,L,U,P)
g = P*f;
y = L\g;
d = U\y;
A