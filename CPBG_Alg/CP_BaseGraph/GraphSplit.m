function [CP_Cell, PTIME] = GraphSplit(rough_graph, skeleton, CI_table_1, CI_table_2)
% This method finds node with only one edge in the graph
% use them to calculate the longest value of the shortest
% distance in the graph. And find the appropriate cut point
% according to the point on this path

%% inital
    node = size(rough_graph, 2);
    idx = 1:node;
    G = graph(rough_graph);
    CP_Cell = {};
%% find the longest path in single edge node
    PathTime = tic;
    [Path, rough_graph] = FindPath(rough_graph, skeleton, CI_table_1, CI_table_2, node);
%% Split with subgraph
    if isempty(Path)
        [graph_con, graph_con_size] = conncomp(G);
        [max_number, max_index] = maxk(graph_con_size, 2);
        VA = find(graph_con == max_index(1));
        VB = find(graph_con == max_index(2));
        VC = setdiff(idx, [VA, VB]);
        Pa = union(VA, VC);
        Pb = union(VB, VC);
        CP_Cell{size(CP_Cell, 2)+1} = Pa;
        CP_Cell{size(CP_Cell, 2)+1} = Pb;
    end
%% Graph Split
    if ~isempty(Path)
        %[Va, Vb, Vc, Pa, Pb] = PathSplitBFS(rough_graph, Path, CI_table_1, CI_table_2);
        %[Va, Vb, Vc, Pa, Pb] = PathSplitBFS_DegreeFirst(rough_graph, Path, CI_table_1, CI_table_2);
        %[Va, Vb, Vc, Pa, Pb, counts] = PathSPlitBFS_RFindPath(rough_graph, Path, CI_table_1, CI_table_2)
    end
    CP_Cell{size(CP_Cell, 2)+1} = Pa;
    CP_Cell{size(CP_Cell, 2)+1} = Pb;
    % CP_Cell{size(CP_Cell, 2)+1} = Vc;
    PTIME = toc(PathTime);
end

