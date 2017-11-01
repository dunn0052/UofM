function draw(name,color,d,f)
    [verts,free,edges] = defo.get_shape(name);
    v = verts;
    if nargin >= 3
        v(free,:) = v(free,:) + reshape(d, [2, length(free)])';
    end
    x = [v(edges(:,1),1) v(edges(:,2),1)]';
    y = [v(edges(:,1),2) v(edges(:,2),2)]';
    plot(x,y,'Color',color);
    hold on;
    scatter(v(:,1),v(:,2),'filled', 'MarkerFaceColor','r');
    scatter(v(free,1),v(free,2),'filled', 'MarkerFaceColor',color);
    if nargin >= 4
        f = reshape(f, [2, length(free)])';
        quiver(v(free,1),v(free,2), f(:,1),f(:,2), 0, 'Color','b','LineWidth',2);
    end
    hold off;
    vmin = min(v);
    vmax = max(v);
    margin = max(vmax - vmin)*0.2;
    axis image;
    axis([vmin(1)-margin vmax(1)+margin vmin(2)-margin vmax(2)+margin]);
end
