clc
clear

% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2

% CPBGratio = zeros(1, 15);
% CAPAratio = zeros(1, 15);
% CPratio = zeros(1, 15);
% CPBG_Split_Time = zeros(1, 15);
% CAPA_Split_Time = zeros(1, 15);
% CP_Split_Time = zeros(1, 15); 
first_count = 1;
data_counts = 2;
tt = tic;
for count = first_count:data_counts
    [CPBG_Score, CAPA_Score, CP_Score, ...
        CPBG_PC_Time, CAPA_PC_Time, CP_PC_Time, ...
        CPBG_ratio, CAPA_ratio, CP_ratio] = BinaryInferenceTest_f(count);
    Total_CPBG_Score_R(count) = CPBG_Score(:, 1);
    Total_CPBG_Score_P(count) = CPBG_Score(:, 2);
    Total_CPBG_Score_F1(count) = CPBG_Score(:, 3);
    Total_CPBG_PC_Time(count) = CPBG_PC_Time;
    Total_CPBG_ratio(count) = CPBG_ratio;
    
    Total_CAPA_Score_R(count) = CAPA_Score(:, 1);
    Total_CAPA_Score_P(count) = CAPA_Score(:, 2);
    Total_CAPA_Score_F1(count) = CAPA_Score(:, 3);
    Total_CAPA_PC_Time(count) = CAPA_PC_Time;
    Total_CAPA_ratio(count) = CAPA_ratio;
    
    Total_CP_Score_R(count) = CP_Score(:, 1);
    Total_CP_Score_P(count) = CP_Score(:, 2);
    Total_CP_Score_F1(count) = CP_Score(:, 3);
    Total_CP_PC_Time(count) = CP_PC_Time;
    Total_CP_ratio(count) = CP_ratio;
end
timexs = toc(tt);
data_set_name = {'cancer', 'asia', 'child', 'mildew', 'water', ...
    'insurance', 'Alarm', 'barley', 'hailfinder', 'win95pts', ...
    'pathfinder', 'andes', 'Pigs', 'Link', 'munin2'};

subplot(3, 1, 1)
plot(first_count:data_counts, Total_CPBG_ratio(first_count:data_counts), ...
    first_count:data_counts, Total_CP_ratio(first_count:data_counts), '--', ...
    first_count:data_counts, Total_CAPA_ratio(first_count:data_counts), '.-');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Cut ratio');
legend('CPBG', 'CP', 'CAPA');

% subplot(3, 1, 1)
% plot(first_count:data_counts, Total_CPBG_Score_R(first_count:data_counts), ...
%     first_count:data_counts, Total_CP_Score_R(first_count:data_counts), '--', ...
%     first_count:data_counts, Total_CAPA_Score_R(first_count:data_counts), '.-');
% xticks(first_count:data_counts);
% xticklabels(data_set_name(first_count:data_counts));
% title('Recall');
% legend('CPBG', 'CP', 'CAPA');


subplot(3, 1, 2)
plot(first_count:data_counts, Total_CPBG_PC_Time(first_count:data_counts), ...
    first_count:data_counts, Total_CP_PC_Time(first_count:data_counts), '--', ...
    first_count:data_counts, Total_CAPA_PC_Time(first_count:data_counts), '.-');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('PC Time');
legend('CPBG', 'CP', 'CAPA');

% subplot(3, 1, 2)
% plot(first_count:data_counts, Total_CPBG_Score_P(first_count:data_counts), ...
%     first_count:data_counts, Total_CP_Score_P(first_count:data_counts), '--', ...
%     first_count:data_counts, Total_CAPA_Score_P(first_count:data_counts), '.-');
% xticks(first_count:data_counts);
% xticklabels(data_set_name(first_count:data_counts));
% title('Precision');
% legend('CPBG', 'CP', 'CAPA');   

subplot(3, 1, 3)
plot(first_count:data_counts, Total_CPBG_Score_F1(first_count:data_counts), ...
    first_count:data_counts, Total_CP_Score_F1(first_count:data_counts), '--', ...
    first_count:data_counts, Total_CAPA_Score_F1(first_count:data_counts), '.-');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('F1 Score');
legend('CPBG', 'CP', 'CAPA');
