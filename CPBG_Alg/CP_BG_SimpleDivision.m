clc;
clear;
Num_dataset = 8;
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
for Time = 1:Times
    % ----------------------- generate data ------------------------
    data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
    % --------------------- find CI information --------------------
    [CI_table_0, CI_table_1, CI_table_2, edge_ind, condition_set, direction_x, direction_y] = DsepTable(data, K_order, nodes, p_value);
    CI_ifo = CI_table_2;
    % --------------------- Get rough graph ------------------------
    rough_graph = ones(nodes, nodes);
    for i = 1:nodes
        for j = 1:nodes
            if CI_ifo(i,j) == 1     % 如果Ds_Temp表明独立，则令RCP_skeleton为0
                rough_graph(i,j) = 0;
                rough_graph(j,i) = 0;
            end 
        end
    end
    rough_graph = rough_graph - eye(nodes);
%     subplot(1, 3, 1)
%     plot(graph(rough_graph))
    % Segmentation algorithm based on graph theory
    S = digraph(skeleton);
    subplot(1, 4, 1);
    plot(S);
    title('Graph')
%     [CP_Cell, PTIME] = GraphSplit(rough_graph, skeleton, CI_table_1, CI_table_2);
    [CP_Cell, SplitTime] = GraphSplitPathSet(rough_graph, skeleton, CI_table_1, CI_table_2, CP_Cell);
    
    
    
    
end