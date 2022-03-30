function [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG_Viz(G, O_G, names)
%GRAPHSPLITPATHSETG This is an equivalent algorithm, and the passed-in parameter is G
% Visualize version
    node_sizeO_G = numnodes(O_G);
    node_sizeG = numnodes(G);
    Split_graph_Cell = {};
    Split_flag = false;
    VertexCutSet = [];
    if node_sizeG <= max(floor(node_sizeO_G / 10), 3)
        Split_graph_Cell{size(Split_graph_Cell, 2)+1} = G;
        VertexCutSet = [];
        Split_flag = true;
    end
    if ~Split_flag
        [connectivity_detection, connect_set_size] = conncomp(G);
        if size(connect_set_size, 2) > 1
            for i = 1:size(connect_set_size, 2)
                node_names_set = table2cell(G.Nodes);
                node_names = node_names_set(find(connectivity_detection == i));
                G_temp = subgraph(G, node_names);
                Split_graph_Cell{size(Split_graph_Cell, 2)+1} = G_temp;
            end
            Split_flag = true;         
        end
        [X, Y] = FindTwoNodeG_Weight(G);
        XY_Index = TransformToArray_Node(G, [X, Y]);
        P1 = MarkNode(G, XY_Index, 1, 2, 1, 'CPBG');
        if ~Split_flag && numnodes(G) > 1
            short_path = shortestpath(G, X, Y);
            if size(short_path, 2) < 4
                Split_graph_Cell{size(Split_graph_Cell, 2)+1} = G;
                Split_flag = true;
            end
        end
        if ~Split_flag && numnodes(G) > 1
            [Split_graph_Cell, VertexCutSet] = PathSplit_PSG_Viz(G, X, Y, names);
            Vertex_Index = TransformToArray_Node(G, VertexCutSet);
            P1 = MarkNode(G, Vertex_Index, 1, 2, 2, 'CPBG');
        end
    end    
end

