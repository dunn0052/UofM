function draw(d, f)
    if nargin == 0
        defo.draw('simple','k');
    else
        defo.draw('simple',[0.8,0.8,0.8]);
        hold on;
        f = reshape(f, [length(f)/2, 2])';
        defo.draw('simple','k',d,f(:));
        hold off;
    end
end
