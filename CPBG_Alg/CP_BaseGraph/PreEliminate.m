function [rough_graph, skeleton, names, data, idxNow] = PreEliminate(G, rough_graph, skeleton, names, data, idx)
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
    [CPBG_Cell] = TransformToArray(Split_graph_Cell, G);
    for i = 1:size(CPBG_Cell, 2)
        k = CPBG_Cell{i};
        Cell_len_pre(i) = size(k, 2);
    end
    [~, Index_pre] = max(Cell_len_pre);
    G_select = Split_graph_Cell{Index_pre};
    will_find_index_node = table2cell(G_select.Nodes)';
    base_node = table2cell(G.Nodes)';
    [~, Index_set_pre] = ismember(will_find_index_node, base_node);
    Index_num_pre = setdiff(idx, Index_set_pre);
    rough_graph(Index_num_pre, :) = [];
    rough_graph(:, Index_num_pre) = [];
    skeleton(Index_num_pre, :) = [];
    skeleton(:, Index_num_pre) = [];
    data(:, Index_num_pre) = [];
    names = names(Index_set_pre);
    idxNow = 1:size(skeleton, 1);
end

