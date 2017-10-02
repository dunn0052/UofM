function A = interchange(A, i, j)
if (i <= size(A,1)) && (j <= size(A,1))
    a = A(i,:);
    b = A(j,:);
    A(i,:) = b;
    A(j,:) = a;
else
    disp("Value exceeds row length")
end
