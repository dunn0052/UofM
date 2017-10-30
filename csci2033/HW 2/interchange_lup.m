function [U_new, L_new, P_new] = interchange_lup(U, i, j, L, P)
U = interchange(U,i,j);
P = interchange(P,i,j);
if i > 1
    for k = 1:(i-1)
       temp = L(i,k);
       L(i,k) = L(j,k);
       L(j,k) = temp;
    end
end   
U_new = U;
P_new = P;
L_new = L;