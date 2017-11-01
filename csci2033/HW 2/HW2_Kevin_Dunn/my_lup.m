function [L, U, P] = my_lup(A)
n = size(A,2);
L = eye(n);
P = eye(n);
U = A;
for i = 1:(n)
    [~,j] = max(abs(U(i:n,i)));
    [U,L,P] = interchange_lup(U,i,(j+i-1),L,P);
    if abs(U(i,i))<(10^(-12))
        break;
    end
    for k = (i+1):(n)
        p = (U(k,i)/U(i,i));
        [U,L] = replacement_lu(U,k,i,p,L);
    end
end
