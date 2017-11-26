function visualize(P, P_tilde, M, t)
subplot(1,2, 1);
scatter(P(1,:), P(2,:), 'k', 'filled');
add_padding(P);
subplot(1,2, 2);
scatter(P_tilde(1,:), P_tilde(2,:), 'k', 'filled');
add_padding(P_tilde);
if nargin > 2
    P_fit = M*P + repmat(t, 1,size(P,2));
    hold on;
    scatter(P_fit(1,:), P_fit(2,:), 'r', 'filled');
    plot([P_fit(1,:); P_tilde(1,:)], [P_fit(2,:); P_tilde(2,:)], 'r');
    hold off;
end
end

function add_padding(P)
pmin = min(P,[],2);
pmax = max(P,[],2);
margin = max(pmax - pmin)*0.2;
axis image;
axis([pmin(1)-margin pmax(1)+margin pmin(2)-margin pmax(2)+margin]);
end
