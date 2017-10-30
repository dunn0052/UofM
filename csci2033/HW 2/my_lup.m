function [L, U, P] = my_lup(A)
n = size(A,1);
L = eye(n);
P = eye(n);
U = A;
for i = 1:(n-1)
    [val,j] = max(abs(U(i:(size(U,1)),i)));
    [U,L,P] = interchange_lup(U,i,j,L,P);
    if abs(U(i,i))<(10^(-12))
        break;
    end
    for k = (i+1):n
        p = (U(k,i)/U(i,i));
        [U,L] = replacement_lu(U,k,i,p,L);
    end
end
