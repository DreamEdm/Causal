clc
clear
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
Num_dataset = 13;
[skeleton, names] = LoadingDataset(Num_dataset);

% inital
skeleton = sortskeleton(skeleton);
nodes = size(skeleton,1);
nSample = 500;
K_order = 2;
p_value = 0.05;
Times = 3;
K_CAPA = [];
K_CPBG = [];
CAPA_time = [];
CPBG_Time = [];
for i = 1:Times
    data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
    
    [CI_table_0, CI_table_1, CI_table_2, ...   
        edge_ind, condition_set, direction_x, direction_y] ...
        = DsepTable(data, K_order, nodes, p_value);
    CI_ifo = CI_table_2;
    [rough_graph] = GetRoughGraph(CI_ifo);
    G = graph(rough_graph, names);
    CPBG_time = tic;
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
    CPBG_Time(i) = toc(CPBG_time);
    CAPA_time = tic;
    [cut_set,nodeA,nodeB,r_s] = CAPA_cut(data);
    PPA = unique([nodeA,cut_set]); PPB = unique([nodeB,cut_set]);
    CAPA_Time(i) = toc(CAPA_time);
    if size(PPA, 2) < size(PPB, 2)
        K_CAPA(i) = size(PPB, 2);
    else
        K_CAPA(i) = size(PPA, 2);
    end
    temp1 = Split_graph_Cell{1};
    for k = 1:size(Split_graph_Cell, 2)-1
        temp2 = Split_graph_Cell{k+1};
        if size(temp1.Nodes, 1) < size(temp2.Nodes, 1)
            temp1 = temp2;
        end
    end
    K_CPBG(i) = size(temp1.Nodes, 1);
end

AVG_K_CAPA = sum(K_CAPA) / Times;
AVG_K_CPBG = sum(K_CPBG) / Times;
AVG_CAPA_TIME = sum(CAPA_Time) / Times;
AVG_CPBG_TIME = sum(CPBG_Time) / Times;





