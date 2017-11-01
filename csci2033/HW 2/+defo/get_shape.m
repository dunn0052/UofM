function [verts,free,edges] = get_shape(name)
    if name=='simple'
        verts = [0 0; 1 0; 1 1; 2 0; 2 1; 3 0];
        free = [2 3 4 5];
        edges = [1 2; 1 3; 2 3; 2 4; 2 5; 3 4; 3 5; 4 5; 4 6; 5 6];
    end
end
