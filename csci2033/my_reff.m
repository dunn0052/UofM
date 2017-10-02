function A = my_reff(A)
for y = 1:(size(A,2)-1)
    %pick max value of column below all finished rows
    [~,index] = max(abs(A(y:(size(A,1)),y)));
    %interchange abs max pivot column to current one
    A = interchange(A,y,index);
    %scale pivot to 1
    A = scaling(A,y,1/A(y,y));
    for x = y:(size(A,1)-1)
        %removing values below row in column
        A = replacement(A,x+1,y,-A(x+1,y));
    end
    %gauss-jordan elim once done with column bwlow
    j = y-1;
    while (y > 1 ) && (j > 0)
        A = replacement(A,y-j,y,-A(y-j,y));
        j = j - 1;
    end
end