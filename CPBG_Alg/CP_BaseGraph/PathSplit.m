function [VA, VB, VC, Pa, Pb] = PathSplit(rough_graph, Path, CI_table_1, CI_table_2)
    split_flag = false;
    Index = ceil(size(Path, 2) / 2);
    
    Index_for = Index;
    TempC = [];
    
    temp_rough_graph = rough_graph;
    G = graph(temp_rough_graph);
    first_con = conncomp(G);
    counts_rough_graph = tabulate(first_con);
    if size(counts_rough_graph, 1) <= 1
        M = [Index];
        temp_rough_graph(:, Path(M)) = 0;
        temp_rough_graph(Path(M), :) = 0;
        testing_counts = tabulate(conncomp(graph(temp_rough_graph)));
        testing_counts = sortrows(testing_counts, 2, 'descend');
        if size(testing_counts, 1) >= 2 && testing_counts(2, 3) > 20
            VA = find(first_con == testing_counts(1, 1));
            VB = find(first_con == testing_counts(2, 1));
            VC = setdiff(first_con, [VA, VB]);
            Pa = union(VA, VC);
            Pb = union(VB, VC);
            split_flag = true;
        end
    end
    if ~split_flag
        Index_left = Index;
        Index_right = Index;
        for i = 1:Index_for
            if split_flag
                break
            end
            temp_rough_graph = rough_graph;
            G = graph(temp_rough_graph);
            repeat_con = conncomp(G);
            Index_left = Index_left - 1;
            Index_right = Index_right - 1;
            M = sort([M, Index_left, Index_right]);
            temp_rough_graph(:, Path(M)) = 0;
            temp_rough_graph(Path(M), :) = 0;
            repeat_testing_counts = tabulate(conncomp(graph(temp_rough_graph)));
            repeat_testing_counts = sortrows(repeat_testing_counts, 2, 'descend');
            if size(repeat_testing_counts, 1) >= 2 && repeat_testing_counts(2, 3) > 20
                VA = find(repeat_con == repeat_testing_counts(1, 1));
                VB = find(repeat_con == repeat_testing_counts(2, 1));
                VC = setdiff(first_con, [VA, VB]);
                Pa = union(VA, VC);
                Pb = union(VB, VC);
                split_flag = true;
            end
        end
    end
end

