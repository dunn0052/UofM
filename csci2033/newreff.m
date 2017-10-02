function A = newreff(A)
k = 1;
l = 1;
while (k < size(A,1)) && (l < size(A,2))
    [val, index] = max(abs(A(l,k:size(A,1))));
    interchange(A,k,index);
    if val == 0
        l = l+1;
    else
        A = scaling(A,k,1/A(k,l));
        for i = 1:k-1
            A = replacement(A,i,k,-A(i,l)/A(k,l));
        end
        k = k+1;
        l = l+1;
    end
end