function [P1] = MarkNode(G, PointSet, i, j, k, Titl)
    if isempty(i) || isempty(j) || isempty(k)
        i = 1;j = 1;k = 1;
    end
    CC = ones(1, size(G.Nodes, 1));
    CC(PointSet) = 2;
    subplot(i, j, k);
    P1 = plot(G);
    set(P1, 'NodeCData', CC);
    map=[0.4 0.6 0.7;1 0 0];
    colormap(map);
    if ~isempty(Titl)
        title(Titl);
    end
end

