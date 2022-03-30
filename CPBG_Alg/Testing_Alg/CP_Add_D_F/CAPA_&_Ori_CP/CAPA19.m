function [RCP_skeleton,Time_CAPA_Opt_Partition,Time_PC_CAPA_Opt,originalSize_currentSize_maxSubsetSize] = CAPA19(data,skeleton,conSize,Ds_order,Ds_Temp)
%   PC_RCP Summary of this function goes here
%   Detailed explanation goes here
    node = size(skeleton,1);
%      tic
%     [Ds_Temp,Acell,Bcell,Ccell] = find_Ds_Temp_Cell(data,Ds_order);
%      Time_Ds_Temp_ReCIT = toc
    RCP_Cell = {};
    RCP_skeleton = ones(node,node);
    tic
    
    [RCP_skeleton,RCP_Cell] = CAPA19_Main(data,data,RCP_skeleton,1:node,RCP_Cell,skeleton,Ds_Temp,0);
    Time_CAPA_Opt_Partition = toc
    %------------------------remove redundance-------------------------------------------------
    tic
    c  = size(RCP_Cell,2);
    Size_Of_RCP_Cell =[];
    for i = 1:c
        Size_Of_RCP_Cell = [Size_Of_RCP_Cell,size(RCP_Cell{i},2)];
    end
    [a,b] = sort(Size_Of_RCP_Cell,'descend');
    Tmep_Cell = RCP_Cell;
    RCP_Cell = {};
    RCP_Cell{1} = Tmep_Cell{b(1)};
    for p = 2:c
        flag = 0;
        aa = Tmep_Cell{b(p)};
        for d = 1:size(RCP_Cell,2)
%             aa = Tmep_Cell{b(p)};
            bb = RCP_Cell{d};
            if length(aa) == length(intersect(aa,bb))
                flag = 1;
                break;
            end
        end
        if flag == 0;
            RCP_Cell{size(RCP_Cell,2)+1} = Tmep_Cell{b(p)};
        end
    end
    originalSize_currentSize_maxSubsetSize = [c,size(RCP_Cell,2),size(RCP_Cell{1},2)]
    Time_Remove_Redundance = toc
    %-------------------------------------------------------------------------------------------    
    for i = 1:node
        for j = 1:node
            if Ds_Temp(i,j) == 1
                RCP_skeleton(i,j) = 0;
                RCP_skeleton(j,i) = 0;
            end 
        end
    end
    %---------------------------------RCP_KCI----------------------------------------------------
    tic
    for k = sort(1:size(RCP_Cell,2),'descend')
%         if size(RCP_Cell{k}{1},2) > 20
%             conSizeR = 3;
%         else
            conSizeR = conSize;
%         end
        RCP_skeleton = KCI_split_linear(data(:,RCP_Cell{k}),RCP_Cell{k},RCP_skeleton,conSizeR,Ds_order);
    end
    Time_PC_CAPA_Opt = toc
end

