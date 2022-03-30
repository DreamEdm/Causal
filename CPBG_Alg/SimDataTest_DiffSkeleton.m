clc
clear

%% Set Basic Inital
Sample = 750;
Nodes = 40;
nIndegree = 1.5;
nFreeNode = 5;
Sample_step = 10;
TargetNodes = 100;
NodeSizeSet = {};
%% Different Nodes VS
for count = 1:floor((TargetNodes-Nodes+Sample_step)/Sample_step)
    NodeSizeSet{size(NodeSizeSet,2)+1} = Nodes;
    [CPBG_Score, CAPA_Score, CP_Score, ...
        CPBG_PC_Time, CAPA_PC_Time, CP_PC_Time, ...
        CPBG_ratio, CAPA_ratio, CP_ratio] = SimDataTest_DiffSkeleton_f(Sample, Nodes, ...
        nIndegree, nFreeNode);
    Nodes = Nodes + Sample_step;
    Total_CPBG_Score_R(count) = CPBG_Score(1);
    Total_CPBG_Score_P(count) = CPBG_Score(2);
    Total_CPBG_Score_F1(count) = CPBG_Score(3);
    Total_CPBG_PC_Time(count) = CPBG_PC_Time;
    Total_CPBG_ratio(count) = CPBG_ratio;
    
    Total_CAPA_Score_R(count) = CAPA_Score(1);
    Total_CAPA_Score_P(count) = CAPA_Score(2);
    Total_CAPA_Score_F1(count) = CAPA_Score(3);
    Total_CAPA_PC_Time(count) = CAPA_PC_Time;
    Total_CAPA_ratio(count) = CAPA_ratio;
    
    Total_CP_Score_R(count) = CP_Score(1);
    Total_CP_Score_P(count) = CP_Score(2);
    Total_CP_Score_F1(count) = CP_Score(3);
    Total_CP_PC_Time(count) = CP_PC_Time;
    Total_CP_ratio(count) = CP_ratio;
end

%% Plot
X_counts = 1:floor(TargetNodes/Nodes);
[ha, pos] = tight_subplot(3, 1, [.01 .03], [.1 .01], [.01 .01]);

axes(ha(1));
plot(X_counts, Total_CPBG_ratio(X_counts), ...
    X_counts, Total_CP_ratio(X_counts), '--', ...
    X_counts, Total_CAPA_ratio(X_counts), '.-');
xticks(X_counts);
xticklabels(NodeSizeSet(X_counts));
title('Cut ratio');
legend('CPBG', 'CP', 'CAPA');

axes(ha(2));
plot(X_counts, Total_CPBG_PC_Time(X_counts), ...
    X_counts, Total_CP_PC_Time(X_counts), '--', ...
    X_counts, Total_CAPA_PC_Time(X_counts), '.-');
xticks(X_counts);
xticklabels(NodeSizeSet(X_counts));
title('PC Time');
legend('CPBG', 'CP', 'CAPA');

axes(ha(3));
plot(X_counts, Total_CPBG_Score_F1(X_counts), ...
    X_counts, Total_CP_Score_F1(X_counts), '--', ...
    X_counts, Total_CAPA_Score_F1(X_counts), '.-');
xticks(X_counts);
xticklabels(NodeSizeSet(X_counts));
title('F1 Score');
legend('CPBG', 'CP', 'CAPA');