function [Cell, VertexCutSet] = PathSplit_PSG_DynamicTesting(G, X, Y, names, Base_num)
%PATHSPLIT_PSG This is an equivalent algorithm, and the passed-in parameter is G
    %% Inital
    Split_G = G;
    Cell = {};
    M = [];
    Nei_Cell = {};
    split_flag = false;
    path_flag = false;
    counts = 0;
    %% Alg 1
    while ~split_flag
        [connectivity_detection, connect_set_size] = conncomp(Split_G);
        if ~path_flag
            counts = counts + 1;
            Path = shortestpath(Split_G, X, Y);
            if ~isempty(Path)
                for count = 1:size(Path, 2)
                    Path_dense(count) = size(neighbors(G, Path{count}), 1);
                end
                if size(Path, 2) > 5
                    Index = WeightJudgeCutNode_DynamicTesting(Path, Path_dense, Base_num);
                    Split_G = rmnode(Split_G, Path(Index));
                    M = [M, Path(Index)];
                else
                    Index = ceil(size(Path, 2)/2);
                    Split_G = rmnode(Split_G, Path(Index));
                    M = [M, Path(Index)];
                end
            else
                path_flag = true;
            end
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
            VertexCutSet = M;
end

