function [VA, VB, VC, Pa, Pb] = PathSplitBFS_DegreeFirst(rough_graph, Path, CI_table_1, CI_table_2)
    split_flag = false;
    node = 1:size(rough_graph, 2);
    M = [];
    
    temp_rough_graph = rough_graph;
    G = graph(temp_rough_graph);
    test_connective = conncomp(G);
    counts_subgraph = tabulate(test_connective);
    if size(counts_subgraph, 1) <= 1
        node_degrees = sum(rough_graph);
        [node_degrees_sort, node_degrees_index] = sort(node_degrees, 'descend');
        node_index_for = size(Path, 2);
        for i = 1:node_index_for
            if split_flag
                break
            end
            M = [M, node_degrees_index(i)];
            temp_rough_graph(:, M) = 0;
            temp_rough_graph(M, :) = 0;
            G_con = graph(temp_rough_graph);
            [sub_graph_number, sub_graph_size] = conncomp(G_con);
            [k_maxsize, k_maxsize_index] = maxk(sub_graph_size, 2);
            if k_maxsize(2) >= k_maxsize(1)*0.15 
                split_flag = true;
                VA = find(sub_graph_number == k_maxsize_index(1));
                VB = find(sub_graph_number == k_maxsize_index(2));
                VC = setdiff(node, [VA, VB]);
                Pa = union(VA, VC);
                Pb = union(VB, VC);
            end
        end
    end
    
    
end

