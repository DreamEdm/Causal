clc
clear
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
Num_dataset = 7;
[skeleton, names] = LoadingDataset(Num_dataset);
% Inital
skeleton = sortskeleton(skeleton);
Times = 1;
for Time = 1:Times
    nodes = size(skeleton,1);
    nSample = 250;
    K_order = 2;
    p_value = 0.05;
    CP_Cell_G = {};
    idx = 1:nodes;
    counts = 0;
    PC_threshold = 5;
    % ----------------------- reverse DAG --------------------------
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    subplot(1, 2, 1)
    plot(graph(Reverse_skeleton))
    % ----------------------- generate data ------------------------
    data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
    % --------------------- find CI information --------------------
%     [CI_table_0, CI_table_1, CI_table_2, edge_ind, condition_set, direction_x, direction_y] = DsepTable(data, K_order, nodes, p_value);
    tic;
    [CI_table_2,AM,BM,CM,DM] = find_Ds_Temp(data,K_order);
    CI_ifo = CI_table_2;
    CI_ifo_Time = toc
    % --------------------- Get rough graph ------------------------
    [rough_graph] = GetRoughGraph(CI_ifo);
    % --------------------- Generate CP_Cell recursively -----------
    G = graph(rough_graph, names);
    tic;
    [CP_Cell_G, VertexCutSet] = SplitBaseGraphG(G, G, CP_Cell_G, idx, counts, names);
    Split_Time = toc
    tic
    [CP_Cell] = TransformToArray(CP_Cell_G, G);
    Transform_Time = toc
    tic
    [CP_Cell] = RemoveRedunance(CP_Cell);
    Remove_Time = toc
    tic
    for k = sort(1:size(CP_Cell,2),'descend')
        conSizeR = PC_threshold;
        CPBG_skeleton = KCI_split_linear(data(:,CP_Cell{k}),CP_Cell{k},rough_graph,conSizeR,K_order);
    end
%     for k = sort(1:size(CP_Cell,2),'descend')
%         conSizeR = PC_threshold;
%         CPBG_skeleton = PC_skeleton_CAPA(data(:,CP_Cell{k}),CP_Cell{k},rough_graph,conSizeR,K_order);
%     end
    PC_Time = toc
%     for i = 1:size(CP_Cell, 2)
%         counts = CP_Cell{i};
%         CPBG_skeleton = PC_Algorithm(data(:, counts), CP_Cell{i}, rough_graph, p_value, PC_threshold);
%     end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    subplot(1, 2, 2)
    plot(graph(CPBG_skeleton))
    SkeletonScore = ScoreSkeleton(CPBG_skeleton, skeleton)
end