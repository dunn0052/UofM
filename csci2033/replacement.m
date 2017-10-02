function A = replacement(A,i,j,s)
if (i <= size(A,1)) && (j <= size(A,1))
    A(i,:) = A(i,:) + s*A(j,:);
else
    disp("Value exceeds row length")
end