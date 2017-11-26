function x = least_squares(A, b)

[~,R] = my_qr(A);

x = back_sub(R,b);