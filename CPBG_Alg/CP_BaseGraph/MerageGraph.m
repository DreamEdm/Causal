function [merge_rough_graph] = MerageGraph(rough_graph, CI_ifo_1, CI_ifo_2, skeleton)
% Used to merge some unexpectedly independent nodes using low-level CI-table
    flag = true;
        if flag
        node = size(rough_graph, 2);
        merge_rough_graph = rough_graph;
        G = graph(merge_rough_graph);
        each_node_edge_sum = sum(merge_rough_graph);
        zero_edge_node = find(each_node_edge_sum(1, :) == 0);
        sub_graph_index = conncomp(G);
        sub_graph_num = unique(sub_graph_index);
        if size(sub_graph_num, 2) >= 2
            for i = 1:size(sub_graph_num, 2)
                sub_graph_counts(i) = size(find(sub_graph_index == i), 2);
            end
            [~,temp_index] = maxk(sub_graph_counts, 1);
            will_merging_graph = sub_graph_num;
            will_merging_graph(temp_index) = [];
            for p = 1:size(will_merging_graph, 2)
                will_merge_node = intersect(find(sub_graph_index == will_merging_graph(p)), zero_edge_node);
                for q = 1:size(will_merge_node, 2)
                    node_rows_index = CI_ifo_1(:, will_merge_node(q)) == 0;
                    merge_rough_graph(node_rows_index, will_merge_node(q)) = 1;
                    merge_rough_graph(will_merge_node(q), node_rows_index) = 1;
                end
            end
        end
    end
    
    G = graph(merge_rough_graph);
    if isempty(find(conncomp(G) == 2, 1))
        flag = false;
    end
    
    if flag
        G = graph(merge_rough_graph);
        each_node_edge_sum = sum(merge_rough_graph);
        single_edge_node = find(each_node_edge_sum(1, :) == 1);
        sub_graph_index = conncomp(G);
        sub_graph_num = unique(sub_graph_index);
        if size(sub_graph_num, 2) >= 2
            for i = 1:size(sub_graph_num, 2)
                sub_graph_counts(i) = size(find(sub_graph_index == i), 2);
            end
            [~,temp_index] = maxk(sub_graph_counts, 1);
            will_merging_graph = sub_graph_num;
            will_merging_graph(temp_index) = [];
            for p = 1:size(will_merging_graph, 2)
                will_merge_node = intersect(find(sub_graph_index == will_merging_graph(p)), single_edge_node);
                for q = 1:size(will_merge_node, 2)
                    node_rows_index = CI_ifo_1(:, will_merge_node(q)) == 0;
                    merge_rough_graph(node_rows_index, will_merge_node(q)) = 1;
                    merge_rough_graph(will_merge_node(q), node_rows_index) = 1;
                end
            end
        end
    end
    
    G = graph(merge_rough_graph);
    if isempty(find(conncomp(G) == 2, 1))
        flag = false;
    end
    
    if flag
        each_node_edge_sum = sum(merge_rough_graph);
        twice_edge_node = find(each_node_edge_sum(1, :) == 2);
        sub_graph_index = conncomp(G);
        sub_graph_num = unique(sub_graph_index);
        if size(sub_graph_num, 2) >= 2
            for i = 1:size(sub_graph_num, 2)
                sub_graph_counts(i) = size(find(sub_graph_index == i), 2);
            end
            [~,temp_index] = maxk(sub_graph_counts, 1);
            will_merging_graph = sub_graph_num;
            will_merging_graph(temp_index) = [];
            for p = 1:size(will_merging_graph, 2)
                will_merge_node = intersect(find(sub_graph_index == will_merging_graph(p)), twice_edge_node);
                for q = 1:size(will_merge_node, 2)
                    node_rows_index = CI_ifo_1(:, will_merge_node(q)) == 0;
                    merge_rough_graph(node_rows_index, will_merge_node(q)) = 1;
                    merge_rough_graph(will_merge_node(q), node_rows_index) = 1;
                end
            end
        end
    end


    for i = 1:node
        merge_rough_graph(i, i) = 0;
    end
    %% Visualize
    G_ori = graph(rough_graph);
    G_new = graph(merge_rough_graph);
    subplot(1, 4, 2);
    plot(G_ori);
    title('Origin Skeleton');
    subplot(1, 4, 3);
    plot(G_new);
    title('New merging Skeleton');
    
