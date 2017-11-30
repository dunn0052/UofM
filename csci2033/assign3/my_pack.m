function beta = my_pack(M,t)

beta(1:4,1) = reshape(transpose(M), 4,1);
beta(5,1) = t(1,1);
beta(6,1)= t(2,1);
