function A = my_reff(A)
for y = 1:(size(A,2)-1)
    disp(A);
    %pick max value of column below all finished rows
    [val,index] = max(A(y:(size(A,1)),y));
    disp(val);
    disp(index+y-1);
    %scale pivot to 0
    A = scaling(A,y,1/A(y,y));
    for x = y:(size(A,1)-1)
        %removing values below row in column
        A = replacement(A,x+1,y,-A(x+1,y));
    end
    %attempting gauss jordan - not very well though
    %should take pivot entry and subtract scaled versions from
    %entries above it until it runs out of space
    j = y;
        while (y > 1) && (j > 0)
            A = replacement(A,y-j+1,y,-A(y-j+1,y));
            j = j - 1;
        end
end