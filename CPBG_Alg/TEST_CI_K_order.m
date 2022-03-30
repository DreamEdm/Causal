clc;
clear;
Num_dataset = 9;
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
[skeleton, names] = LoadingDataset(Num_dataset);
% inital
skeleton = sortskeleton(skeleton);
nodes = size(skeleton,1);
nSample = 250;
K_order = 2;
p_value = 0.05;
Times = 2;
subplot(1, 2, 1)
plot(digraph(skeleton))
for Time = 1:Times
    % ----------------------- generate data ------------------------
    data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
    % --------------------- find CI information --------------------
    [CI_table_0, CI_table_1, CI_table_2, edge_ind, condition_set, direction_x, direction_y] = DsepTable(data, K_order, nodes, p_value);
    CI_ifo0 = CI_table_0;
    CI_ifo1 = CI_table_1;
    CI_ifo2 = CI_table_2;
    % reverse CI table
    rough_graph0 = ones(nodes, nodes);
    rough_graph1 = ones(nodes, nodes);
    rough_graph2 = ones(nodes, nodes);
    for i = 1:nodes
        for j = 1:nodes
            if CI_ifo0(i,j) == 1     % 如果Ds_Temp表明独立，则令RCP_skeleton为0
                rough_graph0(i,j) = 0;
                rough_graph0(j,i) = 0;
            end 
        end
    end
    for i = 1:nodes
        for j = 1:nodes
            if CI_ifo1(i,j) == 1     % 如果Ds_Temp表明独立，则令RCP_skeleton为0
                rough_graph1(i,j) = 0;
                rough_graph1(j,i) = 0;
            end 
        end
    end
    for i = 1:nodes
        for j = 1:nodes
            if CI_ifo2(i,j) == 1     % 如果Ds_Temp表明独立，则令RCP_skeleton为0
                rough_graph2(i,j) = 0;
                rough_graph2(j,i) = 0;
            end 
        end
    end
    rough_graph0 = rough_graph0 - eye(nodes);
    rough_graph1 = rough_graph1 - eye(nodes);
    rough_graph2 = rough_graph2 - eye(nodes);
    % reverse Skeleton
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    %% merge graph
    [merge_graph] = MerageGraph(rough_graph2, CI_ifo1, CI_ifo2, skeleton);
    
    %% plot
    subplot(1, 6, 1);
    plot(digraph(skeleton))
    title('Origin Graph')
    subplot(1, 6, 2);
    plot(graph(Reverse_skeleton))
    title('Origin skeleton');
    subplot(1, 6, 3);
    plot(graph(rough_graph0))
    title('K-order 0')
    subplot(1, 6, 4);
    plot(graph(rough_graph1))
    title('K-order 1')
    subplot(1, 6, 5);
    plot(graph(rough_graph2))
    title('K-order 2')
    subplot(1, 6, 6);
    plot(graph(merge_graph))
    title('Merge graph');
    
end