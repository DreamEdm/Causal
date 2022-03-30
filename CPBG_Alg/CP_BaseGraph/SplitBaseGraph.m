function [CP_Cell, VertexCutSet] = SplitBaseGraph(Cut_G, G, CP_Cell, idx, counts)
    counts = counts + 1;
    Temp_Cut_rough_graph = Cut_rough_graph;
    [~, d] = size(Cut_rough_graph);
    
    [Split_Cell, VerlatexCutSet] = GraphSplitPathSet(Cut_rough_graph);
    
    if size(Split_Cell, 2) == 1
        CP_Cell{size(CP_Cell, 2)+1} = idx(Split_Cell);
    else
        for i = 1:size(Split_Cell, 2)
            idx = idx(Split_Cell{i});
            [CP_Cell, VertexCutSet] = SplitBaseGraph(rough_graph(:, Split_Cell{i}), rough_graph, CP_Cell, idx, counts);
        end
    end
end


