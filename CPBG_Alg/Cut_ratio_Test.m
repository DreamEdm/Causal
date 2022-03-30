clc
clear
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
Num_dataset = 12;
[skeleton, names] = LoadingDataset(Num_dataset);

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
for i = 1:Times
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
%     [CI_table_2,AM,BM,CM,DM] = find_Ds_Temp(data,K_order);
%     CI_ifo = CI_table_2;
%     [rough_graph] = GetRoughGraph(CI_ifo);
    G = graph(Reverse_skeleton, names);
    tic
%     P1 = plot(G);
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
    if ~isempty(VertexCutSet)
        CC = ones(1, nodes);
        transtable = table2cell(G.Nodes)';
        [~, Index] = ismember(VertexCutSet, transtable);
        CC(Index) = 2;
        P1 = plot(G);
        set(P1, 'NodeCData', CC);
        map=[0 0 1;1 0 0];
        colormap(map)
    end
    [CPBG_Cell] = TransformToArray(Split_graph_Cell, G);
    for i = 1:size(CPBG_Cell, 2)
        k = CPBG_Cell{i};
        Cell_len(:, i) = size(k, 1);
    end
    [~, Index] = max(Cell_len);
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(Split_graph_Cell{Index}, Split_graph_Cell{Index}, names);
    if ~isempty(VertexCutSet)
        CC = ones(1, nodes);
        transtable = table2cell(G.Nodes)';
        [~, Index] = ismember(VertexCutSet, transtable);
        CC(Index) = 2;
        P1 = plot(G);
        set(P1, 'NodeCData', CC);
        map=[0 0 1;1 0 0];
        colormap(map)
    end
    G1 = Split_graph_Cell{1};
    G2 = Split_graph_Cell{2};
    ratioCPBG = max([size(G1.Nodes, 1), size(G2.Nodes, 1)])/Cell_len(Index)
    CPBG_Split = toc;
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
    ida = find(Pa == 1)';
    idb = find(Pb == 1)';
    idc = find(Pc == 1)';
    %-------------------------------- 20200306
    idxA = idx(ida);
    idxB = idx(idb);
    idxC = idx(idc);
    %-------------------------------- 20200306
    % 保留了D分离集
    ida = unique([ida,idc]);
    idb = unique([idb,idc]);
    Ra = idx(ida);
    Rb = idx(idb);
    ratioCAPA = max([length(Ra),length(Rb)])/s
%     tic
%     [idxA,idxB,idxCut,Pa,Pb,Pc] = CAPA_Split(data,Reverse_skeleton,idx);
%     ida = find(Pa == 1)';
%     idb = find(Pb == 1)';
%     idc = find(Pc == 1)';
%     %-------------------------------- 20200306
%     idxA = idx(ida);
%     idxB = idx(idb);
%     idxC = idx(idc);
%     %-------------------------------- 20200306
%     % 保留了D分离集
%     ida = unique([ida,idc]);
%     idb = unique([idb,idc]);
%     Ra = idx(ida);
%     Rb = idx(idb);
%     PA = unique([nodeA,cut_set]); PB = unique([nodeB,cut_set]);
%     ratioCP = max([length(PA),length(PB)])/s;
%     CP_Split = toc
end