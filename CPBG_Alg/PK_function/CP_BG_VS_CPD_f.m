function [CPD_skeleton_score, CPBG_skeleton_score, CPD_time, CPBG_time] = CP_BG_VS_CPD_f(count)
    [skeleton, names] = LoadingDataset(count);
    
    skeleton = sortskeleton(skeleton);
    Times = 3;
    Score_CPD = zeros(Times, 3);
    Times_CPD = zeros(Times, 1);
    Times_CPD_Split = zeros(Times, 1);
    Score_CPBG = zeros(Times, 3);
    Times_CPBG = zeros(Times, 1);
    Times_CPBG_Split = zeros(Times, 1);
    
    for Time = 1:Times
        nSample = 500;
        conSize = 5;
        Ds_order = 2;
        nodes = size(skeleton, 2);
        p_value = 0.05;
        PC_threshold = 5;
        CP_Cell_G = {};
        CPD_Cell = {};
        Rd_Cell = {};
        idx = 1:nodes;
        counts = 0;
        sigmod = 0;
        CPD_skeleton = ones(nodes,nodes);
        %----------------------------- DATA -------------------------
        data = SEMDataGenerator(skeleton,nSample, 'uniform', 0.3);
        % ---------------------------- CI_ifo -----------------------
        [CI_table_2,AM,BM,CM,DM] = find_Ds_Temp(data,Ds_order);
        % ---------------------------- CPBG -------------------------
        CPBGtic = tic;
        CI_ifo = CI_table_2;
        [rough_graph] = GetRoughGraph(CI_ifo);
        G = graph(rough_graph, names);
        [CP_Cell_G, VertexCutSet] = SplitBaseGraphG(G, G, ...
            CP_Cell_G, idx, counts, names);
        [CPBG_Cell] = TransformToArray(CP_Cell_G, G);
        [CPBG_Cell] = RemoveRedunance(CPBG_Cell);
%         for k = sort(1:size(CPBG_Cell,2),'descend')
%             conSizeR = PC_threshold;
%             CPBG_skeleton = KCI_split_linear(data(:,CPBG_Cell{k}),CPBG_Cell{k},rough_graph,conSizeR,Ds_order);
%         end
%         for k = sort(1:size(CPBG_Cell,2),'descend')
%             conSizeR = PC_threshold;
%             CPBG_skeleton = PC_skeleton_CAPA(data,CPBG_Cell{k},rough_graph,conSizeR,Ds_order);
%         end
        for k = sort(1:size(CPBG_Cell,2),'descend')
            conSizeR = PC_threshold;
            CPBG_skeleton = PC_skeleton_CPD(data,CPBG_Cell{k},rough_graph,conSizeR);
        end
        % ---------------------------- SCORE ------------------------
        Score_CPBG(Time, :) = ScoreSkeleton(CPBG_skeleton, skeleton)
        Times_CPBG(Time, 1) = toc(CPBGtic)
        % ---------------------------- CPD --------------------------
        CPDtic = tic;
        [CPD_skeleton, CPD_Cell, Rd_Cell] = CPD_Main(data, data, ...
            idx, CPD_Cell, Rd_Cell, CPD_skeleton, CI_table_2, sigmod);
        [CPD_Cell] = RemoveRedunance(CPD_Cell);
%         for k = sort(1:size(CPD_Cell,2),'descend')
%             conSizeR = PC_threshold;
%             CPD_skeleton = KCI_split_linear(data(:,CPD_Cell{k}),CPD_Cell{k},rough_graph,conSizeR,Ds_order);
%         end
%         for k = sort(1:size(CPD_Cell,2),'descend')
%             conSizeR = PC_threshold;
%             CPD_skeleton = PC_skeleton_CAPA(data,CPD_Cell{k},rough_graph,conSizeR,Ds_order);
%         end
        for k = sort(1:size(CPD_Cell,2),'descend')
            conSizeR = PC_threshold;
            CPD_skeleton = PC_skeleton_CPD(data,CPD_Cell{k},rough_graph,conSizeR);
        end
        % ---------------------------- SCORE ------------------------
        Score_CPD(Time, :) = ScoreSkeleton(CPD_skeleton, skeleton)
        Times_CPD(Time, 1) = toc(CPDtic)
    end
    CPD_skeleton_score = sum(Score_CPD)/Times;
    CPD_time = sum(Times_CPD)/Times;
    CPBG_skeleton_score = sum(Score_CPBG)/Times;
    CPBG_time = sum(Times_CPBG)/Times;
end

