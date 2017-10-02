function A = scaling(A,i,s)
if (i <= size(A,1))
    A(i,:) = A(i,:)*s;
else
    disp("Value exceeds row length")
end