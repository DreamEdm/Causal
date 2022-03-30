function [CP_Cell, VertexCutSet] = SplitBaseGraphG(Cut_G, G, CP_Cell, idx, counts, names)
    counts = counts + 1;
    size_d = numnodes(Cut_G);
    
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(Cut_G, G, names);
    if size(Split_graph_Cell, 2) == 1
        CP_Cell{size(CP_Cell, 2)+1} = Split_graph_Cell{1};
    else
        for i = 1:size(Split_graph_Cell, 2)
            [CP_Cell, VertexCutSet] = SplitBaseGraphG(Split_graph_Cell{i}, G, CP_Cell, idx, counts, names);
        end
    end
    VertexCutSet = [];
    
    
end

