function [Cell] = PathSplit_PS2(rough_graph)
%PATHSPLIT_PS2 Find vertex cut set in different path
%   if it really can't divide it by only path??

    % Inital
    node = size(rough_graph, 2);
    G = graph(rough_graph);
    Cell = {};
    M = [];
    split_flag = false;
    % Cycle multiple paths to find vertex cut set
    while ~split_flag
        [X, Y] = FindTwoNode(rough_graph);
        Path = shortestpath(G, X, Y);
        Index = ceil(size(Path, 2)/2);
        X_Index = Index;
        Y_Index = size(Path, 2) - Index;
        [X_dist_node_set, X_dist] = nearest(G, X, X_Index);
        [Y_dist_node_set, Y_dist] = nearest(G, Y, Y_Index);
        X_dist_node = X_dist_node_set(find(X_dist == X_Index));
        Y_dist_node = Y_dist_node_set(find(Y_dist == Y_Index));
        vertex_cut_set = intersect(X_dist_node, Y_dist_node);
        G = rmnode(G, vertex_cut_set);
    end
end

