function [Cell, VertexCutSet] = PathSplit_PSG(G, X, Y, names)
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
%                     % Alg 1
%                     Index = ceil(size(Path, 2)/2)-1;
%                     Index_left = sum(Path_dense(:, 1:(Index-1)));
%                     Index_right = sum(Path_dense(:, (Index+1):size(Path, 2)));
%                     min_dense = min(Index_left, Index_right);
%                     max_dense = max(Index_left, Index_right);
%                     temp =min_dense/max_dense;
%                     Index_weight = 2.7.^temp - 2.7;
%                      if max_dense == Index_left
%                         Split_G = rmnode(Split_G, Path(Index + round(Index_weight)));
%                         M = [M, Path(Index + round(Index_weight))];
%                     else
%                         Split_G = rmnode(Split_G, Path(Index - round(Index_weight)));
%                         M = [M, Path(Index - round(Index_weight))];
%                      end

%                      % Alg 2
%                     weight_flag = false;
%                     Index = ceil(size(Path, 2)/2);
%                     old_Index = Index;
%                     while ~weight_flag
%                         
%                         Index_left_degree = sum(Path_dense(:, 1:(Index-1)));
%                         Index_right_degree = sum(Path_dense(:, (Index+1):size(Path, 2)));
%                         min_dense = min(Index_left_degree, Index_right_degree);
%                         max_dense = max(Index_left_degree, Index_right_degree);
%                         
%                         if max_dense == Index_left_degree
%                             old_Index = Index;
%                             Index = Index - 1;
%                         else
%                             old_Index = Index;
%                             Index = Index + 1;
%                         end
%                         Index_left_degree = sum(Path_dense(:, 1:(Index-1)));
%                         Index_right_degree = sum(Path_dense(:, (Index+1):size(Path, 2)));
%                         min_dense = min(Index_left_degree, Index_right_degree);
%                         max_dense = max(Index_left_degree, Index_right_degree);
%                         if max_dense == Index_left_degree
%                             if Index >= old_Index
%                                 weight_flag = true;
%                             end
%                         else
%                             if Index <= old_Index
%                                 weight_flag = true;
%                             end
%                     Split_G = rmnode(Split_G, Path(Index));
%                     M = [M, Path(Index)];
                    
                    % Alg 3
                    Index = WeightJudgeCutNode(Path, Path_dense);
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
%             nodes = sum(connect_set_size);
%             
%             set_index = find(connect_set_size <= floor(nodes*0.5));
%             
%             if ~isempty(set_index)
%                 smallsize_num = [];
%                 smallsize_name = {};
%                 set_name = table2cell(Split_G.Nodes)';
%                 for p = 1:size(set_index, 2)
%                     smallsize_num = [smallsize_num, find(connectivity_detection == set_index(p))];
%                 end
%                 
%                 [~, temp_max_graph_index] = sort(connect_set_size, 'descend');
%                 smallsize_name = set_name(smallsize_num);
%                 temp_max_set = temp_max_graph_index(1);
%                 temp_min_set = temp_max_graph_index(2);
%                 if connect_set_size(temp_min_set) < floor(nodes*0.5)
%                     connectivity_detection(smallsize_num) = temp_max_set;
%                 else
%                     connectivity_detection(smallsize_num) = temp_min_set;
%                 end
%                 connect_set_size(set_index) = [];
%                 temp_max_graph_index = setdiff(temp_max_graph_index, set_index);
%                 for i = 1:size(connect_set_size, 2)
%                     Temp_G = G;
%                     ori_node_names = table2cell(Temp_G.Nodes)';
%                     split_node_names = table2cell(Split_G.Nodes)';
%                     sub_index = find(connectivity_detection == temp_max_graph_index(i));
%                     node_ifo = [split_node_names(sub_index), M];
%                     Sub_G = subgraph(G, node_ifo);
%                     Cell{size(Cell, 2)+1} = Sub_G;
%                     split_flag = true;
%                 end
%             else
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
%             end
        end
            VertexCutSet = M;
    end
end

    %% Alg 2
%             for i = 1:size(connect_set_size, 2)
%                 if connect_set_size(i) == 1
%                     continue
%                 end
%                 Temp_G = G;
%                 Index_set = find(connect_set_size == 1);
%                 node_ifo = table2cell(Temp_G.Nodes)';
% %                 true_node_ifo = node_ifo(find(connectivity_detection == i))';
% %                 Temp_G = rmnode(Temp_G, true_node_ifo);
%                 if isempty(Index_set)
%                     true_node_ifo = node_ifo(find(connectivity_detection ~= i))';
%                     Temp_G = rmnode(Temp_G, true_node_ifo);
%                 else
%                     true_node_ifo = node_ifo(find(connectivity_detection ~= i & connectivity_detection ~= Index_set))';
%                     Temp_G = rmnode(Temp_G, true_node_ifo);
%                 end
%                 
%                 Cell{size(Cell, 2)+1} = Temp_G;
%                 VertexCutSet = M;
%                 split_flag = true;
%             end
        

