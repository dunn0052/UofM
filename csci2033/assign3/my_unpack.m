function [M,t] = my_unpack(beta)

t(1,1) = beta(5,1);
t(2,1) = beta(6,1);

M = transpose(reshape(beta(1:4),2,2));
end