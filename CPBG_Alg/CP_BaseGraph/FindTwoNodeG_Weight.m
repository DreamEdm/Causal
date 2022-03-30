function [X_name_select, Y_name_select] = FindTwoNodeG_Weight(G)
%FINDTWONODE_WEIGHT 
%   When we find multiple nodes with the same distance in the graph, 
%   we need to score them to determine the accurate points
    Path_Cell = {};
    dis = distances(G);
    dis_index = isinf(dis);
    xxx = find(dis_index == 1);
    if ~isempty(xxx)
        dis(xxx) = 0;
    end
    [MA, IA] = max(dis);
    [Mx, My] = max(MA);
    X = IA(My);
    Y = My;
    [Index_X, Index_Y] = find(dis == Mx);
    size_Index = size(Index_X, 1)/2;
    Index_X = Index_X(1:size_Index)';
    Index_Y = Index_Y(1:size_Index)';
    node_names = table2cell(G.Nodes);
    for i = 1:size(Index_X, 2)
        X_name_select = node_names(Index_X(i));
        Y_name_select = node_names(Index_Y(i));
        Path_Cell{size(Path_Cell, 2)+1} = shortestpath(G, X_name_select, Y_name_select);
    end
    
    for i = 1:size(Path_Cell, 2)
        T = Path_Cell{i};
        for count = 1:size(T, 2)
            Path_dense(count) = size(neighbors(G, T{count}), 1);
        end
        Path_set_dense(i) = sum(Path_dense);
    end
    [~, max_Index] = max(Path_set_dense);
    X_name = Index_X(max_Index);
    Y_name = Index_Y(max_Index);
end

