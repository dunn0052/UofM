function [U_new, L_new] = replacement_lu(U, i, j, s, L)
n = size(U,1);
L(i,j) = s;
for k = 1:n
U(i,k) = U(i,k) - s*U(j,k);
end
L_new = L;
U_new = U;
    
