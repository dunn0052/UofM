function A = my_rref(A)
d = 0;
for y = 1:(size(A,2)-1)
    %pick max value of column below all finished rows
    [val,index] = max(abs(A(y:(size(A,1)),y+d)));
    %interchange abs max pivot column to current one
    while (val == 0) && (y + d < size(A,2)-1)
        d = d + 1;
        [val,index] = max(abs(A(y:(size(A,1)),y+d)));
    end
    A = interchange(A,y,index + y - 1);
    %scale pivot to 1
    A = scaling(A,y,1/A(y,y+d));
    for x = y:(size(A,1)-1)
        %removing values below row in column
        A = replacement(A,x+1,y,-A(x+1,y+d));
    end
    %gauss-jordan elim once done with column bwlow
    j = y-1;
    while (y > 1 ) && (j > 0)
        A = replacement(A,y-j,y,-A(y-j,y));
        j = j - 1;
    end
end
disp(A);