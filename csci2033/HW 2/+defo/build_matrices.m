function [edgeMat,freeMat] = build_matrices(verts,free,edges)
    nVerts = size(verts,1);
    nFree = length(free);
    nEdges = size(edges,1);
    freeMat = zeros(nFree, nVerts);
    freeMat(sub2ind(size(freeMat), 1:nFree, free)) = 1;
    edgeMat = zeros(nEdges, nVerts);
    edgeMat(sub2ind(size(edgeMat), (1:nEdges)', edges(:,2))) = 1;
    edgeMat(sub2ind(size(edgeMat), (1:nEdges)', edges(:,1))) = -1;
end
