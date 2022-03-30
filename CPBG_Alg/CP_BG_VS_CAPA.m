% This script only scores for skeletons
clc;
clear;

first_count = 1;
data_counts = 10;

for count = first_count:data_counts
    [CAPA_skeleton_score, CPBG_skeleton_score, ...
        CAPA_time, CPBG_time,  T_Times_CAPA_Split, ...
        T_Times_CPBG_Split] = CP_BG_VS_CAPA_f(count);
    
    Total_CAPA_Score_R(count) = CAPA_skeleton_score(1)
    Total_CAPA_Score_P(count) = CAPA_skeleton_score(2)
    Total_CAPA_Score_F1(count) = CAPA_skeleton_score(3)
    AVG_CAPA_Time(count) = CAPA_time
    
    Total_CPBG_Score_R(count) = CPBG_skeleton_score(1)
    Total_CPBG_Score_P(count) = CPBG_skeleton_score(2)
    Total_CPBG_Score_F1(count) = CPBG_skeleton_score(3)
    AVG_CPBG_Time(count) = CPBG_time
end

data_set_name = {'cancer', 'asia', 'child', 'mildew', 'water', ...
    'insurance', 'Alarm', 'barley', 'hailfinder', 'win95pts', ...
    'pathfinder', 'andes', 'Pigs', 'Link', 'munin2'};

subplot(4, 1, 1)
plot(first_count:data_counts, Total_CAPA_Score_R(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_R(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Recall');
legend('CAPA', 'CP BG')

subplot(4, 1, 2)
plot(first_count:data_counts, Total_CAPA_Score_P(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_P(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Precision');
legend('CAPA', 'CP BG');

subplot(4, 1, 3)
plot(first_count:data_counts, Total_CAPA_Score_F1(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_F1(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('F1-Score');
legend('CAPA', 'CP BG');

subplot(4, 1, 4)
plot(first_count:data_counts, AVG_CAPA_Time(first_count:data_counts), ...
    first_count:data_counts, AVG_CPBG_Time(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Time');
legend('CAPA', 'CP BG');