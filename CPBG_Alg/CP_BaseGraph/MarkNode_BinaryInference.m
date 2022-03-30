function [P1] = MarkNode_BinaryInference(G, PointSet1, PointSet2, i, j, k, Titl)
    if isempty(i) || isempty(j) || isempty(k)
        i = 1;j = 1;k = 1;
    end
    CC = ones(1, size(G.Nodes, 1));
    CC(PointSet1) = 2;
    CC(PointSet2) = 3;
    subplot(i, j, k);
    P1 = plot(G);
    set(P1, 'NodeCData', CC);
    map=[0.4 0.6 0.7;1 0 0; 0 0 1];
    colormap(map);
    if ~isempty(Titl)
        title(Titl);
    end
end

