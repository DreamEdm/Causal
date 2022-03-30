function [RCP_skeleton,Acell,Bcell,Ccell,TimeCP_CAPA,TimePC_CAPA] = PC_RCP(data,skeleton,conSize,Ds_order,Ds_Temp,Acell,Bcell,Ccell)
%   PC_RCP Summary of this function goes here
%   Detailed explanation goes here
    node = size(skeleton,1);
%      tic
%     [Ds_Temp,Acell,Bcell,Ccell] = find_Ds_Temp_Cell(data,Ds_order);
%      Time_Ds_Temp_ReCIT = toc
    RCP_Cell = {};
    RCP_skeleton = ones(node,node);
    tic
    [RCP_skeleton,RCP_Cell] = RCP_Main(data,data,RCP_skeleton,1:node,RCP_Cell,skeleton,Ds_Temp,0); 
    Time_CAPA_OLD = toc
    %------------------------remove redundance-------------------------------------------------
    c  = size(RCP_Cell,2);
    Size_Of_RCP_Cell =[];
    for i = 1:c
        Size_Of_RCP_Cell = [Size_Of_RCP_Cell,size(RCP_Cell{i}{1},2)];
    end
    [a,b] = sort(Size_Of_RCP_Cell,'descend');
    Tmep_Cell = RCP_Cell;
    RCP_Cell = {};
    RCP_Cell{1}{1} = Tmep_Cell{b(1)}{1};
    for p = 2:c
        flag = 0;
        for d = 1:size(RCP_Cell,2)
            aa = Tmep_Cell{b(p)}{1};
            bb = RCP_Cell{d}{1};
            if length(Tmep_Cell{b(p)}{1}) == length(intersect(aa,bb))
                flag = 1;
            end
        end
        if flag == 0;
            RCP_Cell{size(RCP_Cell,2)+1}{1} = Tmep_Cell{b(p)}{1};
        end
    end
    originalSize_currentSize_maxSubsetSize = [c,size(RCP_Cell,2),size(RCP_Cell{1}{1},2)]
    %-------------------------------------------------------------------------------------------    
    for i = 1:node
        for j = 1:node
            if Ds_Temp(i,j) == 1
                RCP_skeleton(i,j) = 0;
                RCP_skeleton(j,i) = 0;
            end 
        end
    end
     %-------------------------------------------------------------------------------------------
%     Score_RCP = Score_RCP + SplitError(RCP_skeleton,skeleton);
%     RCP_Split_Error = Score_RCP/PT
%       beforeKCI = ScoreSkeleton(RCP_skeleton,skeleton)
    %---------------------------------RCP_KCI----------------------------------------------------
    tic
    for k = 1:size(RCP_Cell,2)
%         if size(RCP_Cell{k}{1},2) > 10
%             conSizeR = 3;
%         else
            conSizeR = conSize;
%         end
        RCP_skeleton = KCI_split_linear(data(:,RCP_Cell{k}{1}),RCP_Cell{k}{1},RCP_skeleton,conSizeR, Ds_order);
    end
    Time_PC_CAPA_OLD = toc
end

