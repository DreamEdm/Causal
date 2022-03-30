clc;
clear;
Num_dataset = 7;
% Data index:
% 1 Cancer , 2 Asia , 3 Child , 4 Mildew , 5 Water
% 6 Insurance , 7 Alarm , 8 Barley , 9 Hailfinder
%  10 Win98pts , 11 Pathfinder , 12 Andes , 13 Pig
% 14 Link , 15 munin2
[skeleton, names] = LoadingDataset(Num_dataset);

skeleton = sortskeleton(skeleton);
n = size(skeleton,1);

nSample = 250;
Ds_order = 2;

Times = 2;
for Time = 1:Times
    
end

