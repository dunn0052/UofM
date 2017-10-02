function A = my_rref(A)
for col = 1:size(A,2)-1
    disp(A);
    [val,index] = max(A(col:(size(A,1)),col));
    disp(val);
    A = interchange(A,col,index);
    A = scaling(A,col,1/A(col,col));
    for row = col:(size(A,1)-1)
        A = replacement(A,(row+1),col,-A((row+1),col)/A(col,col));
    end
end