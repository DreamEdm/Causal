function [Cell, VertexCutSet] = PathSplit_PSG_Paththreshold(G, X, Y, names)
%PATHSPLIT_PSG_PATHTHRESHOLD 
%   In order to solve the problem that the complete graph cannot
%   divided, the threshhold of the path length is increased. 
    %% Inital
    Split_G = G;
    Cell = {};
    M = [];
    split_flag = false;
    path_flag = false;
    counts = 0;
    while ~split_flag
        counts = counts + 1;
        Path = shortestpath(G, X, Y);
        if size(Path, 2) < 5 && counts == 1
            path_flag = true;
        else
            Index = ceil(size(Path, 2)/2);
            Split_G = rmnode(Split_G, Path(Index));
            M = [M, Path(Index)];
        end
        [connectivity_detection, connect_set_size] = conncomp(Split_G);
        if path_flag || size(connect_set_size, 2) ~= 1
            if path_flag
                Cell{size(Cell, 2)+1} = G;
                split_flag = true;
            else
                for i = 1:size(connect_set_size, 2)
                    Temp_G = G;
                    ori_node_names = table2cell(Temp_G.Nodes)';
                    split_node_names = table2cell(Split_G.Nodes)';
                    sub_index = find(connectivity_detection == i);
                    node_ifo = [split_node_names(sub_index), M];
                    Sub_G = subgraph(G, node_ifo);
                    Cell{size(Cell, 2)+1} = Sub_G;
                    split_flag = true; 
                end
            end
        end
    end
end

