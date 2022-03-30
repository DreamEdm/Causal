function [Cell, VertexCutSet] = PathSplit_PS(rough_graph, X, Y)
%PATHSPLIT_PS Find vertex cut set in only Path
    
    %% Inital
    Cell = {};
    G = graph(rough_graph);
    M = [];
    split_flag = false;
    %% Alg
    while ~split_flag
        [connectivity_detection, connect_set_size] = conncomp(G);
        if size(connect_set_size, 2) == 1 
            % Find shortest path with X and Y
            Path = shortestpath(G, X, Y);
            % Use path index to cut graph
            Index = ceil(size(Path, 2)/2);
            G = rmnode(G, Path(Index));
            M = [M, Path(Index)];
        else
            for i = 1:size(connect_set_size, 2)
                Cell{size(Cell, 2)+1} = unique([find(connectivity_detection == i), M]);
                VertexCutSet = M;
                split_flag = true;
            end
        end
    end
%     %% Alg
%     while ~split_flag
%         [connectivity_detection, connect_set_size] = conncomp(G);
%         if size(connect_set_size, 2) == 1
%             % Find shortest path with X and Y
%             Path = shortestpath(G, X, Y);
%             % 
%             Index = ceil(size(Path, 2)/2);
%             X_Index = Index;
%             Y_Index = size(Path, 2) - Index;
%             [X_dist_node_set, X_dist] = nearest(G, X, X_Index);
%             [Y_dist_node_set, Y_dist] = nearest(G, Y, Y_Index);
%             X_dist_node = X_dist_node_set(find(X_dist == X_Index));
%             Y_dist_node = Y_dist_node_set(find(Y_dist == Y_Index));
%             vertex_cut_set = intersect(X_dist_node, Y_dist_node);
%             G = rmnode(G, vertex_cut_set);
%         end
%     end
end

