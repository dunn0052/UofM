function [M,t] = affine_fit(P,P_tilde)

Ai = design_matrix(P);


beta = least_squares(Ai,P_tilde);

[M,t] = my_unpack(beta);