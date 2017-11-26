function [P,P_tilde, M,t] = generate_data()
n = 200; % number of points
ne = 20; % number of points constrained to edges
noise = 0.2; % std dev of added noise
M = randn(2,2);
t = randn(2,1);
P = 2*rand(2,n) - 1;
P(1,0*ne+1:1*ne) = -1;
P(1,1*ne+1:2*ne) = +1;
P(2,2*ne+1:3*ne) = -1;
P(2,3*ne+1:4*ne) = +1;
P_tilde = M*P + repmat(t, 1,n) + noise*randn(2,n);
end

% function [P,P_tilde, M,t] = generate_data()
% ne = 32; % edge resolution
% nf = 8; % fill resolution
% noise = 0.1; % std dev of added noise
% M = randn(2,2);
% t = randn(2,1);
% P = [];
% P(1:2,end+1:end+ne) = [+(2*(1:ne)/ne - 1); -ones(1,ne)];
% P(1:2,end+1:end+ne) = [-(2*(1:ne)/ne - 1); +ones(1,ne)];
% P(1:2,end+1:end+ne) = [-ones(1,ne); -(2*(1:ne)/ne - 1)];
% P(1:2,end+1:end+ne) = [+ones(1,ne); +(2*(1:ne)/ne - 1)];
% [xf,yf] = meshgrid(2*(1:nf-1)/nf - 1, 2*(1:nf-1)/nf - 1);
% P(1:2,end+1:end+(nf-1)*(nf-1)) = [xf(:)'; yf(:)'];
% npoints = size(P,2);
% P_tilde = M*P + repmat(t, 1,npoints) + noise*randn(2,npoints);
% end
