function [AVG_CPBG_Score, AVG_CAPA_Score, AVG_CP_Score, ...
    AVG_CPBG_PC_Time, AVG_CAPA_PC_Time, AVG_CP_PC_Time, ...
    AVG_CPBG_ratio, AVG_CAPA_ratio, AVG_CP_ratio] = BinaryInferenceTest_f_Viz(count)
[skeleton, names] = LoadingDataset(count);
    skeleton = sortskeleton(skeleton);
    Times = 3;
    CPBG_ratio = zeros(Times, 1);
    CAPA_ratio = zeros(Times, 1);  
    CP_ratio = zeros(Times, 1);
    
    CPBG_Score = zeros(Times, 3);
    CAPA_Score = zeros(Times, 3);
    CP_Score = zeros(Times, 3);
    
    CPBG_PC_Time = zeros(Times, 1);
    CAPA_PC_Time = zeros(Times, 1);
    CP_CP_Time = zeros(Times, 1);
    
    Num_dataset = count;
    if Num_dataset == 10 || Num_dataset == 12 || Num_dataset == 14
        nodes = size(skeleton, 1);
        idx = 1:nodes;
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
            Cell_len(:, i) = size(k, 1);
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
    nodes = size(skeleton, 2);
    Reverse_skeleton = skeleton;
    for i = 1:nodes
        for j = 1:nodes
            if skeleton(j, i) == 1
                Reverse_skeleton(i, j) = 1;
            end
        end
    end
    
    nSample = 750;
    Ds_order = 2;
    s = size(skeleton,1);
    sizeZ = 5;
    idx = 1:s;
    
    for Time = 1:Times
        % ------------------------- DATA -------------------------
        data = SEMDataGenerator(skeleton, nSample, 'uniform', 0.3);
        [ha, pos] = tight_subplot(1, 3, [.05 .05],[.05 .04],[.01 .01]);
        % ------------------------- CI-Table ---------------------
        [CI_table_2,AM,BM,CM,DM] = find_Ds_Temp(data,Ds_order);
        [rough_graph] = GetRoughGraph(CI_table_2);
        % ------------------------- CPBG -------------------------
        G = graph(rough_graph, names);
        
        [Split_graph_Cell, VertexCutSet] = GraphSplitPathSetG(G, G, names);
        [CPBG_Cell] = TransformToArray(Split_graph_Cell, G);
        for i = 1:size(CPBG_Cell, 2)
            k = CPBG_Cell{i};
            Cell_len(:, i) = size(k, 1);
        end
        CPBG_ratio(Time, 1) = max(Cell_len)/s;
        G_CPBG = graph(rough_graph);
%         [VertexCutSet_S] = TransformToArray_Node(VertexCutSet, G);
%         MarkNode_Cell(G_CPBG, CPBG_Cell, VertexCutSet_S, 1, 3, 1, 'CPBG');
%         MarkNodeHighlight_sub(G_CPBG, CPBG_Cell, 1, 3, 1, 'CPBG');
        MarkNodeHighlightTight(G_CPBG, CPBG_Cell, 1, 'CPBG', ha)
        CPBG_skeleton = rough_graph;
        tic;
%         for i = 1:size(CPBG_Cell, 2)
%             CPBG_skeleton = TraditionPC(data, CPBG_Cell{i}, CPBG_skeleton, sizeZ);
%         end
        for k = sort(1:size(CPBG_Cell,2))
            CPBG_skeleton = KCI_split_linear(data(:, CPBG_Cell{k}), CPBG_Cell{k},  CPBG_skeleton, sizeZ, Ds_order);
        end
%         for k = 1:size(CPBG_Cell,2)
%             Selection = CPBG_Cell{k}';
%             [CPBG_skeleton] = PC_Algorithm(data(:, Selection), Selection, CPBG_skeleton, 0.05, sizeZ);
%         end
        CPBG_PC_Time(Time, 1) = toc;
        CPBG_Score(Time, :) = ScoreSkeleton(CPBG_skeleton, skeleton);
        % ------------------------ CAPA ---------------------------
        [idxA,idxB,idxCut,Pa,Pb,Pc] = CAPA_Split(data,CI_table_2,idx);
        ida = find(Pa == 1)';idb = find(Pb == 1)';idc = find(Pc == 1)';
        ida = unique([ida,idc]);idb = unique([idb,idc]);
        Ra = idx(ida);Rb = idx(idb);
        CAPA_ratio(Time) = max([length(Ra),length(Rb)])/s;
        CAPA_Cell = {};
        CAPA_Cell{size(CAPA_Cell, 2)+1} = Ra;
        CAPA_Cell{size(CAPA_Cell, 2)+1} = Rb;
        CAPA_skeleton = rough_graph;
        G_CAPA = graph(rough_graph);
%         MarkNodeHighlight_sub(G_CAPA, CAPA_Cell, 1, 3, 2, 'CAPA');
        MarkNodeHighlightTight(G_CAPA, CAPA_Cell, 2, 'CAPA', ha);
        tic;
%         CAPA_skeleton = TraditionPC(data, Ra, rough_graph, sizeZ);
%         CAPA_skeleton = TraditionPC(data, Rb, CAPA_skeleton, sizeZ);
        for k = sort(1:size(CAPA_Cell,2),'descend')
            CAPA_skeleton = KCI_split_linear(data(:, CAPA_Cell{k}), CAPA_Cell{k},  CAPA_skeleton, sizeZ, Ds_order);
        end
%         for k = sort(1:size(CAPA_Cell,2),'descend')
%             [CAPA_skeleton] = PC_Algorithm(data(:, CAPA_Cell{k}), CAPA_Cell{k}, CAPA_skeleton, 0.05, sizeZ);
%         end
        CAPA_PC_Time = toc;
        CAPA_Score(Time, :) = ScoreSkeleton(CAPA_skeleton, skeleton);
        % ------------------------ CP -----------------------------
        [idxA,idxB,idxCut,Pa,Pb,Pc] = CAPA_Split(data,CI_table_2,idx);
        ida = find(Pa == 1)';idb = find(Pb == 1)';idc = find(idxCut == 1)';
        Ra = idx(ida);Rb = idx(idb);
        CP_ratio(Time, 1) = max([length(Ra),length(Rb)])/s;
        CP_Cell = {};
        CP_Cell{size(CP_Cell, 2)+1} = Ra;
        CP_Cell{size(CP_Cell, 2)+1} = Rb;
        CP_skeleton = rough_graph;
        G_CP = graph(rough_graph);
%         MarkNodeHighlight_sub(G_CP, CP_Cell, 1, 3, 3, 'CP');
        MarkNodeHighlightTight(G_CP, CP_Cell, 3, 'CP', ha);
        tic;
%         CP_skeleton = TraditionPC(data, Ra, rough_graph, sizeZ);
%         CP_skeleton = TraditionPC(data, Rb, CP_skeleton, sizeZ);
        for k = sort(1:size(CP_Cell,2),'descend')
            CP_skeleton = KCI_split_linear(data(:, CP_Cell{k}), CP_Cell{k},  CP_skeleton, sizeZ, Ds_order);
        end
%         for k = sort(1:size(CP_Cell,2),'descend')
%             [CP_skeleton] = PC_Algorithm(data(:, CP_Cell{k}), CP_Cell{k}, CP_skeleton, 0.05, sizeZ);
%         end
        CP_PC_Time(Times, 1) = toc;
        CP_Score(Time, :) = ScoreSkeleton(CP_skeleton, skeleton);
    end
    
    AVG_CPBG_ratio = sum(CPBG_ratio) / Times;
    AVG_CAPA_ratio = sum(CAPA_ratio) / Times;
%     AVG_CAPA_ratio = [];
    AVG_CP_ratio = sum(CP_ratio) / Times;
    AVG_CPBG_PC_Time = sum(CPBG_PC_Time) / Times;
    AVG_CAPA_PC_Time = sum(CAPA_PC_Time) / Times;
%     AVG_CAPA_PC_Time = [];
    AVG_CP_PC_Time = sum(CP_PC_Time) / Times;
    AVG_CPBG_Score = sum(CPBG_Score) / Times;
    AVG_CAPA_Score = sum(CAPA_Score) / Times;
%     AVG_CAPA_Score = [];
    AVG_CP_Score = sum(CP_Score) / Times;
end

