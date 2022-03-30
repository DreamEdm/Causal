clc
clear
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
counts = 1;
CPBGratio = zeros(1, 15);
CAPAratio = zeros(1, 15);
CPratio = zeros(1, 15);
CPBG_Split_Time = zeros(1, 15);
CAPA_Split_Time = zeros(1, 15);
CP_Split_Time = zeros(1, 15);
for p = 1:counts
    Num_dataset = 3;
    [skeleton, names] = LoadingDataset_filter(Num_dataset);
    if Num_dataset == 10 || Num_dataset == 12 || Num_dataset == 14
        nodes = size(skeleton, 1);
        idx = 1:nodes
        Reverse_skeleton = skeleton;
        for i = 1:nodes
            for j = 1:nodes
                if skeleton(j, i) == 1
                    Reverse_skeleton(i, j) = 1;
                end
            end
        end
        G = graph(Reverse_skeleton, names);
        [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
        [CPBG_Cell] = TransformToArray(Split_graph_Cell, G);
        for i = 1:size(CPBG_Cell, 2)
            k = CPBG_Cell{i};
            Cell_len(:, i) = size(k, 2);
        end
        [~, Index] = max(Cell_len);
        G_select = Split_graph_Cell{Index};
        will_find_index_node = table2cell(G_select.Nodes);
        base_node = table2cell(G.Nodes);
        [~, Index] = ismember(will_find_index_node, base_node);
        Index_num = setdiff(idx, Index);
        skeleton(Index_num, :) = [];
        skeleton(:, Index_num) = [];
        names = names(Index);
    end
    % inital
    skeleton = sortskeleton(skeleton);
    nodes = size(skeleton,1);
    idx = 1:nodes;
    nSample = 500;
    K_order = 2;
    p_value = 0.05;
    Times = 1;
    K_CAPA = [];
    K_CPBG = [];
    CAPA_time = [];
    CPBG_Time = [];
    s = size(skeleton,1);
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    for i = 1:Times
        data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
        % ----------------------------- CPBG ------------------------
        tic;
        G_num = graph(Reverse_skeleton);
        G = graph(Reverse_skeleton, names);
        [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
        if ~isempty(VertexCutSet)
            namess = table2cell(G.Nodes)';
            will_trans_graph = VertexCutSet;
            [~, Index] = ismember(VertexCutSet, namess);
%             P1 = MarkNode(G_num, Index, 1, 3, 1, 'CPBG');
        end
        [CPBG_Cell] = TransformToArray(Split_graph_Cell, G);
        for i = 1:size(CPBG_Cell, 2)
            k = CPBG_Cell{i};
            Cell_len(:, i) = size(k, 2);
        end
        CPBGratio(p) = max(Cell_len)/s
        CPBG_Split_Time = toc;
        % ------------------------------ CAPA -----------------------
        tic
        Reverse_CI = ones(nodes);
        for i = 1:nodes
            for j = 1:nodes
                if Reverse_skeleton(j, i) == 1
                    Reverse_CI(i, j) = 0;
                end
            end
        end
        [idxA,idxB,idxCut,Pa,Pb,Pc] = CAPA_Split(data,Reverse_CI,idx);
        ida = find(Pa == 1)';idb = find(Pb == 1)';idc = find(Pc == 1)';
        ida = unique([ida,idc]);idb = unique([idb,idc]);
        Ra = idx(ida);Rb = idx(idb);
%         P2 = MarkNode(G_num, idc, 1, 3, 2, 'CAPA');
        CAPAratio(p) = max([length(Ra),length(Rb)])/s
        CAPA_Split_Time = toc;
        %-------------------------------- CP -----------------
        tic;
        [idxA,idxB,idxCut,Pa,Pb,Pc] = CAPA_Split(data,Reverse_CI,idx);
        ida = find(Pa == 1)';idb = find(Pb == 1)';idc = find(idxCut == 1)';
        Ra = idx(ida);Rb = idx(idb);
%         P3 = MarkNode(G_num, idc, 1, 3, 3, 'CP');
        CPratio(p) = max([length(Ra),length(Rb)])/s
        CP_Split_Time = toc;
    end
end
% 
data_set_name = {'cancer', 'asia', 'child', 'mildew', 'water', ...
    'insurance', 'Alarm', 'barley', 'hailfinder', 'win95pts', ...
    'pathfinder', 'andes', 'Pigs', 'Link', 'munin2'};
counts = 1:15;
plot(counts, CPBGratio, counts, CAPAratio,'--',  counts, CPratio, '-.')
xticks(counts);
xticklabels(data_set_name);
title('Ratio');
legend('CPBG', 'CAPA', 'CP');
grid on

