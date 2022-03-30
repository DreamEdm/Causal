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
CP_Cell_G = {};
idx = 1:nodes;
counts = 0;
Times = 2;
for Time = 1:Times
    % reverse DAG
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    cc = {idx};
    G_num = graph(Reverse_skeleton);
    G = graph(Reverse_skeleton, names);
%     subplot(1, 3, 1)
%     plot(digraph(skeleton))
%     subplot(1, 3, 2)
%     plot(G_num)
%     subplot(1, 3, 3)
%     plot(G)
    idx = 1:nodes;
    [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG_Viz(G, G, names);
%     G1 = Split_graph_Cell{1};
%     G2 = Split_graph_Cell{2};
%     ratioCPBG = max([size(G1.Nodes, 1), size(G2.Nodes, 1)])/nodes;
%     [CP_Cell_G, VertexCutSet] = SplitBaseGraphG(G, G, CP_Cell_G, idx, counts, names);
    [CP_Cell] = TransformToArray(Split_graph_Cell, G);
    [CP_Cell] = RemoveRedunance(CP_Cell);
    
end