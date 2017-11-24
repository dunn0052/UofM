function [c, v_perp] = ortho_decomp(U,v)

% calculate size once
n = size(U,2);


for i = 1:n
    
    %get col of U
    u = U(:,i);
    %get each c_n
    cn = dot(u,v)/dot(u,u);
    %put elements into c
    c(i,1) = cn;
end

%v_perp is ortho proj via v - comp
v_perp = v - U * c;    
