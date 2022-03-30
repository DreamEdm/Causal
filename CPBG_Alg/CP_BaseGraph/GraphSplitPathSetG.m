function [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, O_G, names)
%GRAPHSPLITPATHSETG This is an equivalent algorithm, and the passed-in parameter is G
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
        if ~Split_flag && numnodes(G) > 1
            short_path = shortestpath(G, X, Y);
            if size(short_path, 2) < 4
                Split_graph_Cell{size(Split_graph_Cell, 2)+1} = G;
                Split_flag = true;
            end
        end
        if ~Split_flag && numnodes(G) > 1
            [Split_graph_Cell, VertexCutSet] = PathSplit_PSG(G, X, Y, names);
        end
    end
   
end

