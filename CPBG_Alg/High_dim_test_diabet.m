clc
clear
for count = 1:5
    Sample = [250, 500, 1000, 1500, 2000];
    [CPBG_Score, CAPA_Score, CP_Score, ...
        CPBG_PC_Time, CAPA_PC_Time, CP_PC_Time, ...
        CPBG_ratio, CAPA_ratio, CP_ratio] = High_dim_test_diabet_f(Sample(count));
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