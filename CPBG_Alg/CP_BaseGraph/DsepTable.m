function [CI_table_0, CI_table_1, CI_table_2, edge_ind, condition_set, direction_x, direction_y] = DsepTable(data, K_order, nodes, alpha)
    %% input:
        % data : which data will be discover causal graph
        % K_order : size of limit condition subset numbers
    %% Output: 
        % CI_table : differernt size of condition subsets
    %% Inital
        CI_table_temp = false(nodes);
        edge_C = size(nchoosek(1:nodes, 2), 1);
        edge_ind = zeros(2, edge_C);
        condition_set = zeros(3, edge_C);
        direction_x = zeros(3, edge_C);
        direction_y = zeros(3, edge_C);
        counts = 1;
    %% Find CI_tables
        % k == 0
        for i = 1:nodes-1
            for j = i+1:nodes
                ind = PaCoTest(data(:,i), data(:,j), [], alpha);
                if ind
                    CI_table_temp(i, j) = 1;
                    CI_table_temp(j, i) = 1;
                    edge_ind([1, 2], counts) = [i, j];
                    counts = counts + 1;
                end
            end
        end
        
        CI_table_0 = CI_table_temp;
        if K_order == 0
            CI_table_1 = [];
            CI_table_2 = [];
            return 
        end
        
        % k == 2
        for i = 1:nodes-1
            for j = i+1:nodes
                if CI_table_temp(i, j) == 0 && CI_table_temp(j, i) == 0
                    for con = 1:nodes
                        if i ~= con && j ~= con && CI_table_temp(i, con) == 0 && CI_table_temp(j, con) == 0
                            ind = PaCoTest(data(:, i), data(:, j), data(:, con), alpha);
                            if ind
                                CI_table_temp(i, j) = 1;
                                CI_table_temp(j, i) = 1;
                                edge_ind([1,2], counts) = [i, j];
                                condition_set(1, counts) = con;
                                x = data(:, i);
                                y = data(:, j);
                                z = data(:, con);
                                res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                                res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                                ind2 = PaCoTest(res1,data(:,con),[],0.05);
                                ind3 = PaCoTest(res2,data(:,con),[],0.05);
                                if ind2
                                    direction_x(1, counts) = con;
                                end
                                if ind3
                                    direction_y(1, counts) = con;
                                end
                                counts = counts + 1;
                                break;
                            end
                        end
                    end
                end
            end
        end
        
        CI_table_1 = CI_table_temp;
        if K_order == 1
            CI_table_2 = [];
            return
        end
        
        % k == 2
        for i = 1:nodes-1
            for j = i+1:nodes
                if CI_table_temp(i, j) == 0 && CI_table_temp(j, i) == 0
                    idx = unique(intersect(find(CI_table_temp(i, :) == 1), find(CI_table_temp(j, :) == 1)));
                    idx = [idx, i, j];
                    con_subset = 1:nodes;
                    con_subset(idx) = [];
                    if length(con_subset) > 2
                        subset_choose = nchoosek(con_subset, 2);
                        for con = 1:size(subset_choose, 1)
                            ind = PaCoTest(data(:, i), data(:, j), data(:, subset_choose(con, :)), alpha);
                            if ind
                                CI_table_temp(i, j) = 1;
                                CI_table_temp(j, i) = 1;
                                edge_ind([1,2], counts) = [i, j];
                                condition_set([1,2], counts) = subset_choose(con, :);
                                x = data(:, i);
                                y = data(:, j);
                                z = data(:, subset_choose(con, :));
                                res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                                res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                                condPa = subset_choose(con, :);
                                for w1 = 1:length(condPa)
                                    ind2 = PaCoTest(res1,data(:,condPa(w1)),[],0.05);
                                    if ind2 == false
                                        break;
                                    end
                                end
                                for w2 = 1:length(condPa)
                                    ind3 = PaCoTest(res2,data(:,condPa(w2)),[],0.05);
                                    if ind3 == false
                                        break;
                                    end
                                end
                                if ind2
                                    direction_x([1, 2], counts) = subset_choose(con, :);
                                end
                                if ind3
                                    direction_y([1, 2], counts) = subset_choose(con, :);
                                end
                                counts = counts + 1;
                            end
                        end
                    end
                end
            end
        end
        
        CI_table_2 = CI_table_temp;
        if K_order == 2
            return
        end
end

