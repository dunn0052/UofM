function [Q,R] = my_qr(A)

%calculate size once
n = size(A,2);
R = eye(n)
%norm of q_1 is first H subspace
H = A(:,1)/norm(A(:,1));
for i = 2:n
    %calculate a_n once per loop
    a_n = A(:,i);
    
    [c, v_proj] = ortho_decomp(H,a_n);
    
    %norm of q_n
    q_n = v_proj/norm(v_proj);
    
    %set col i of H as new orthonormal vec of H
    H(:,i) = q_n; 
end
Q = H;
R = transpose(Q) * A;