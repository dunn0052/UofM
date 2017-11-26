function x = back_sub(U, b)
U(abs(U) < 1e-12) = 0;
if ~istriu(U)
    error('Error in back_sub: Matrix is not upper triangular!');
end
x = U\b;
end
