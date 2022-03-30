clc
clear

% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2

first_count = 1;
data_counts = 8;
tt = tic;

for count = first_count:data_counts
    [CPBG_ratio] = Different_E_step_test_f(count);
    Total_CPBG_ratio(count) = CPBG_ratio;

    Total_CAPA_ratio(count) = CAPA_ratio;

    Total_CP_ratio(count) = CP_ratio;
end
timexs = toc(tt);
