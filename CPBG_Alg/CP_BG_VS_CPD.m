% This script only scores for skeletons
clc;
clear;

first_count = 1;
data_counts = 9;

for count = first_count:data_counts
    [CPD_skeleton_score, CPBG_skeleton_score, ...
        CPD_time, CPBG_time] = CP_BG_VS_CPD_f(count);
    
    Total_CPD_Score_R(count) = CPD_skeleton_score(1)
    Total_CPD_Score_P(count) = CPD_skeleton_score(2)
    Total_CPD_Score_F1(count) = CPD_skeleton_score(3)
    AVG_CPD_Time(count) = CPD_time
    
    Total_CPBG_Score_R(count) = CPBG_skeleton_score(1)
    Total_CPBG_Score_P(count) = CPBG_skeleton_score(2)
    Total_CPBG_Score_F1(count) = CPBG_skeleton_score(3)
    AVG_CPBG_Time(count) = CPBG_time
end

data_set_name = {'cancer', 'asia', 'child', 'mildew', 'water', ...
    'insurance', 'Alarm', 'barley', 'hailfinder', 'win95pts', ...
    'pathfinder', 'andes', 'Pigs', 'Link', 'munin2'};

subplot(4, 1, 1)
plot(first_count:data_counts, Total_CPD_Score_R(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_R(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Recall');
legend('CPD', 'CP BG')

subplot(4, 1, 2)
plot(first_count:data_counts, Total_CPD_Score_P(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_P(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Precision');
legend('CPD', 'CP BG');

subplot(4, 1, 3)
plot(first_count:data_counts, Total_CPD_Score_F1(first_count:data_counts), ...
    first_count:data_counts, Total_CPBG_Score_F1(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('F1-Score');
legend('CPD', 'CP BG');

subplot(4, 1, 4)
plot(first_count:data_counts, AVG_CPD_Time(first_count:data_counts), ...
    first_count:data_counts, AVG_CPBG_Time(first_count:data_counts), '--');
xticks(first_count:data_counts);
xticklabels(data_set_name(first_count:data_counts));
title('Time');
legend('CPD', 'CP BG');








