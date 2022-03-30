function [gcaOBJ] = MarkNode_Cell(G, Cell, VertexCutSet, x, y, z, Titl)
    gcaCell = {};
    for p = 1:size(Cell, 2)
        k = Cell{p};
        Cell_len(:, p) = size(k, 1);
    end
    [~, Index_len] = sort(Cell_len, 'descend');
    CC = ones(1, size(G.Nodes, 1));
    C_Set = intersect(Cell{Index_len(1)}, Cell{Index_len(2)});
    for p = 1:2
        gcaCell{size(gcaCell, 2)+1} = Cell{Index_len(p)};
    end
    gcaCell{size(gcaCell, 2)+1} = C_Set;
    
    for p = 1:3
        CC(gcaCell{p}) = p;
    end
    subplot(x, y, z);
    P1 = plot(G);
    set(P1, 'NodeCData', CC);
    map=[0.57647 0.43922 0.85882;0.95686 0.64314 0.37647;1 0 0;];
    colormap(map);
    fc1 = find(CC == 1);
    fc2 = find(CC == 2);
    
%     highlight(P1, fc1, 'Marker', '^')
%     ffx = get(P1, 'XData');
%     ffy = get(P1, 'YData');
%     for i = 1:length(unique(CC))
%         ()
%     end
    if ~isempty(Titl)
        title(Titl);
    end
end

