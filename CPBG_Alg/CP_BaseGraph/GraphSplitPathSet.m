function [CP_Cell, VertexCutSet] = GraphSplitPathSet(rough_graph, idx, skeleton, CI_table_1, CI_table_2, CP_Cell)
%GRAPHSPLITPATHSET This algorithm is an improved version of the "GraphSplit" algorithm
%   This algorithm finds the shortest path of the 
%   "two farthest nodes" in the graph, and finds the 
%   set of cut points in the middle based on this path. 
%   It is worth noting that we only focus on the midpoint of the path.
    
    %% Inital
    node = size(rough_graph, 2);
    idx = 1:node;
    G = graph(rough_graph);
    Split_flag = false;
    CP_Cell = {};
    Split_Cell = {};
    %% Indivisible conditions
    if node <= max(floor(size(rough_graph, 1)/10), 3)
        CP_Cell{size(CP_Cell, 2)+1} = [idx];
        Split_flag = true;
    end
    
    %% Check the connectivity of the graph
    if ~Split_flag
        [connectivity_detection, connect_set_size] = conncomp(G);
        if size(connect_set_size, 2) > 1
            for i = 1:size(connect_set_size, 2)
                Split_Cell{size(Split_Cell, 2)+1} = find(connectivity_detection == i);
                Split_flag = true;
            end
        end

        %% Find two furthest nodes & PathSplit base on path set
        if ~Split_flag
            [X, Y] = FindTwoNode(rough_graph);
            [Split_Cell, VertexCutSet] = PathSplit_PS(rough_graph, X, Y);
    %         [Split_Cell] = PathSPlit_PS2(rough_graph);
        end

        CP_Cell = Split_Cell;
    end
end

