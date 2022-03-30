function [CAPA_skeleton_score, CPBG_skeleton_score, CAPA_time, CPBG_time, T_Times_CAPA_Split, T_Times_CPBG_Split] = CP_BG_VS_CAPA_f(count)
    [skeleton, names] = LoadingDataset(count);
    
    skeleton = sortskeleton(skeleton);
    Times = 3;
    Score_CAPA = zeros(Times, 3);
    Times_CAPA = zeros(Times, 1);
    Times_CAPA_Split = zeros(Times, 1);
    Score_CPBG = zeros(Times, 3);
    Times_CPBG = zeros(Times, 1);
    Times_CPBG_Split = zeros(Times, 1);
    for Time = 1:Times
        nSample = 250;
        conSize = 5;
        Ds_order = 2;
        nodes = size(skeleton, 2);
        p_value = 0.05;
        PC_threshold = 5;
        CP_Cell_G = {};
        idx = 1:nodes;
        counts = 0;
        
        data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
        % ------------------------------ CAPA -----------------------
        CAPAtic = tic
        [Ds_Temp,AM,BM,CM,DM] = find_Ds_Temp(data,Ds_order);
        [CAPA_skeleton,PTime1,PCTime1,OCM1] = CAPA(data,skeleton,conSize,Ds_order,Ds_Temp);
        Score_CAPA(Time, :) = ScoreSkeleton(CAPA_skeleton, skeleton)
        Times_CAPA(Time, 1) = toc(CAPAtic)
        Times_CAPA_Split(Time, 1) = PTime1
        % ------------------------------ CPBG -----------------------
        CPBGtic = tic
        [Ds_Temp,AM,BM,CM,DM] = find_Ds_Temp(data,Ds_order);
        CI_ifo = Ds_Temp;
        [rough_graph] = GetRoughGraph(CI_ifo);
        G = graph(rough_graph, names);
        Times_Split = tic;
        [CP_Cell_G, VertexCutSet] = SplitBaseGraphG(G, G, CP_Cell_G, idx, counts, names);
        Times_CPBG_Split(Time, 1) = toc(Times_Split)
        tic
        [CP_Cell] = TransformToArray(CP_Cell_G, G);
        Transform_Time = toc
        tic
        [CP_Cell] = RemoveRedunance(CP_Cell);
        Remove_Time = toc
        tic
        for k = sort(1:size(CP_Cell,2),'descend')
            conSizeR = PC_threshold;
            CPBG_skeleton = KCI_split_linear(data(:,CP_Cell{k}),CP_Cell{k},rough_graph,conSizeR,Ds_order);
        end
        PC_Time = toc
%         for i = 1:size(CP_Cell, 2)
%             counts = CP_Cell{i};
%             CPBG_skeleton = PC_Algorithm(data(:, counts), CP_Cell{i}, rough_graph, p_value, PC_threshold);
%         end
        Score_CPBG(Time, :) = ScoreSkeleton(CPBG_skeleton, skeleton)
        Times_CPBG(Time, 1) = toc(CPBGtic)
    end
    CAPA_skeleton_score = sum(Score_CAPA)/Times;
    CAPA_time = sum(Times_CAPA)/Times;
    CPBG_skeleton_score = sum(Score_CPBG)/Times;
    CPBG_time = sum(Times_CPBG)/Times;
    T_Times_CAPA_Split = sum(Times_CAPA_Split)/Times;
    T_Times_CPBG_Split = sum(Times_CPBG_Split)/Times;
end

