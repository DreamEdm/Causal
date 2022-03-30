clc
clear

% Data index:
% 1 Cancer , 2 Asia , 3 Sachs, 4 Child , 5 Mildew , 6 Water
% 7 Insurance , 8 Alarm , 9 Barley , 10 Hailfinder
% 11 Hepar2 12 Win98pts , 13 Andes , 14 Diabetes, 15 Pig

Sample_list = [250, 500, 1000, 1500, 2000];
first_count = 1;
data_counts = 15;
for i = 1:length(Sample_list)
    Sample = Sample_list(i);
    for count = first_count:data_counts
        [CPBG_Score, CAPA_Score, CP_Score, ...
            CPBG_PC_Time, CAPA_PC_Time, CP_PC_Time, ...
            CPBG_ratio, CAPA_ratio, CP_ratio] = BinaryInferenceTest_Sample_f(count, Sample);
        Total_CPBG_Score_R(i, count) = CPBG_Score(:, 1);
        Total_CPBG_Score_P(i, count) = CPBG_Score(:, 2);
        Total_CPBG_Score_F1(i, count) = CPBG_Score(:, 3);
        Total_CPBG_PC_Time(i, count) = CPBG_PC_Time;
        Total_CPBG_ratio(i, count) = CPBG_ratio;

        Total_CAPA_Score_R(i, count) = CAPA_Score(:, 1);
        Total_CAPA_Score_P(i, count) = CAPA_Score(:, 2);
        Total_CAPA_Score_F1(i, count) = CAPA_Score(:, 3);
        Total_CAPA_PC_Time(i, count) = CAPA_PC_Time;
        Total_CAPA_ratio(i, count) = CAPA_ratio;

        Total_CP_Score_R(i, count) = CP_Score(:, 1);
        Total_CP_Score_P(i, count) = CP_Score(:, 2);
        Total_CP_Score_F1(i, count) = CP_Score(:, 3);
        Total_CP_PC_Time(i, count) = CP_PC_Time;
        Total_CP_ratio(i, count) = CP_ratio;
    end
end

data_set_name = {'cancer', 'asia', 'sachs', 'child', 'mildew', 'water', ...
    'insurance', 'alarm', 'barley', 'hailfinder', 'hepar2', 'win95pts', ...
    'andes', 'diabetes', 'pigs'};



