clc
clear

%   Data index:
%   This script is used to test the network partitioning in two modes,
%   a Gaussian Bayies Network and a Conditional Linear Gaussian Bayies
%   Network. 

%   Mode Selection: "GBN"(Gaussian Bayies Network), 
%                   "CLGBN"(Conditional Linear Gaussian Bayies Network)

%   Each schema has a different index number, representing the different
%   data sets that neeed to be read.

%   "GBN"  1:"ecoli70", 2:"magic-niab", 3:"magic-irri", 4:"arth150"
%   "CLGBN"  1:"healthcare", 2:"mehra-complete", 3:"sangiovese"

%   Inital
Sample = 1000;
ModeSelect = "GBN";
if ModeSelect == "GBN"
    Kcounts = 4;
    data_set_name = {'ecoli70', 'magic-niab', 'magic-irri', 'arth150'};
end
if ModeSelect == "CLGBN"
    Kcounts = 3;
    data_set_name = {'healthcare', 'mehra-complete', 'sangiovese'};
end

for count = 2:Kcounts
    [CPBG_Score, CAPA_Score, CP_Score, ...
        CPBG_PC_Time, CAPA_PC_Time, CP_PC_Time, ...
        CPBG_ratio, CAPA_ratio, CP_ratio] = HalfRealTest_f(count, data_set_name, Sample);
    
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
