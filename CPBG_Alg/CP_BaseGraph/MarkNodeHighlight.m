function [gcaOBJ] = MarkNodeHighlight(G, Cell, Titl)
    gcaCell = {};
    for p = 1:size(Cell, 2)
        k = Cell{p};
        Cell_len(:, p) = size(k, 2);
    end
    [~, Index_len] = sort(Cell_len, 'descend');
    C_Set = intersect(Cell{Index_len(1)}, Cell{Index_len(2)});
    P1 = plot(G);
    highlight(P1, Cell{Index_len(1)}, 'Marker', '^', 'NodeColor', [0.57647 0.43922 0.85882], 'MarkerSize', 8);
    highlight(P1, Cell{Index_len(2)}, 'Marker', 's', 'NodeColor', [0.95686 0.64314 0.37647], 'MarkerSize', 8);
    highlight(P1, C_Set, 'Marker', 'p', 'NodeColor', [1 0 0], 'MarkerSize', 8);
end

