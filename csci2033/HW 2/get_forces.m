function f = get_forces(d)
%
% You do NOT need to look inside this function to do the assignment!
%
    [verts,free,edges] = defo.get_shape('simple');
    [edgeMat,freeMat] = defo.build_matrices(verts,free,edges);
    stiffness = 10;
    d = reshape(d, [2, length(free)])';
    e = edgeMat*freeMat'*d;
    e0 = edgeMat*verts;
    l0 = sqrt((e0.*e0)*[1;1]);
    fe = -stiffness*e.*e0*[1;1]./(l0.^3)*[1 1].*e0;
    f = freeMat*edgeMat'*fe;
    f = reshape(f, [length(free)*2, 1]);
end
