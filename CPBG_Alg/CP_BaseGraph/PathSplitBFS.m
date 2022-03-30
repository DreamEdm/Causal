function [VA, VB, VC, Pa, Pb] = PathSplitBFS(rough_graph, Path, CI_table_1, CI_table_2)
    split_flag = false;
    node_index = ceil(size(Path, 2) / 2);
    node_index_for = node_index;
    
    temp_rough_graph = rough_graph;
    G = graph(temp_rough_graph);
    test_connective = conncomp(G);
    counts_subgraph = tabulate(test_connective);
    if size(counts_subgraph, 1) <= 1
        M = [Path(node_index)];
        temp_rough_graph(:, M) = 0;
        temp_rough_graph(M, :) = 0;
        G_con = graph(temp_rough_graph);
        [sub_graph_number, sub_graph_size] = conncomp(G_con);
        [k_maxsize, k_maxsize_index] = maxk(sub_graph_size, 2);
        if k_maxsize(2) >= k_maxsize(1)*0.15 
            split_flag = true;
            VA = find(sub_graph_number == k_maxsize_index(1));
            VB = find(sub_graph_number == k_maxsize_index(2));
            VC = M;
            Pa = union(VA, VC);
            Pb = union(VB, VC);
        end
        if ~split_flag
            for i = 1:node_index_for
                if split_flag
                    break
                end
                temp_rough_graph = rough_graph;
                [neigbor_node, yy] = find(temp_rough_graph(:, M) == 1);
                M = union(neigbor_node, M);
                temp_rough_graph(:, M) = 0;
                temp_rough_graph(M, :) = 0;
                G_con = graph(temp_rough_graph);
                [sub_graph_number, sub_graph_size] = conncomp(G_con);
                [k_maxsize, k_maxsize_index] = maxk(sub_graph_size, 2);
                if k_maxsize(2) >= k_maxsize(1)*0.15 
                    split_flag = true;
                    VA = find(sub_graph_number == k_maxsize_index(1));
                    VB = find(sub_graph_number == k_maxsize_index(2));
                    VC = M;
                    Pa = union(VA, VC);
                    Pb = union(VB, VC);
                end
            end
        end
    end
    if ~split_flag
        VA = 1:node;
        VB = 0;
        VC = 0;
        Pa = union(VA, VC);
        Pb = union(VB, VC);
    end
end

