function [M,t] = my_unpack(beta)

M = transpose(reshape(beta(1:4),2,2));
t(1,1) = beta(5,1);
t(1,2) = beta(6,1);