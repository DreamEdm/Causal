function [Oskeleton,SADAcell] = RCP_Opt_Main(X,data,Cskeleton,idx,SADAcell,skeleton,Ds_Temp,t)
t = t + 1;
Oskeleton = Cskeleton;
[n,d]=size(X);
if d <= max(floor(size(Cskeleton,1)/10),3) %|| t > 5 %adaptive threshold for basic sovler
%     aaaaaaaaaaaaaa  = idx
    SADAcell{size(SADAcell,2)+1} = {idx};
else
    [idxA,idxB,idxCut ,Pa,Pb,Pc]=RCP_Opt_Split_random(X,Ds_Temp,idx); % RCP_Split_final RCP_Opt_Split
%     Partition_Result = [sum(idxA),sum(idxB),sum(idxCut),size(X,2),sum(Pc)]
    Ra = idx(find(Pa == 1)');
    Rb = idx(find(Pb == 1)');
    Rc = idx(find(Pc == 1)');
    
%     if length(intersect([10,12,36,37],unique([Ra,Rb,Rc]))) == 4
%         V1 = idx(find(idxA == 1)')
%         V2 = idx(find(idxB == 1)')
%         C = idx(find(idxCut == 1)')
%         reportPartition1 = Ra
%         reportPartition2 = Rb
%         reportPartition3 = Rc
%     end
    
%     V1 = find(idxA == 1)';
%     V2 = find(idxB == 1)';
%     R1 = idx(V1);
%     R2 = idx(V2);
%     
%     Oskeleton(R1,R2) = 0;
%     Oskeleton(R2,R1) = 0;
    
    if sum(idxA)==0 || sum(idxB)==0 || size(X,2) == sum(Pc)
%         bbbbbbbbbbbbbbbbb  =  unique([Ra,Rb,Rc])
        SADAcell{size(SADAcell,2)+1} = {unique([Ra,Rb,Rc])};
    else
        if length(Ra) ~= length(intersect(Ra,Rc)) && length(Ra) >= 2;
            [Oskeleton,SADAcell] = RCP_Opt_Main( data(:, Ra),data,Oskeleton,Ra,SADAcell,skeleton,Ds_Temp,t);
        end
        if length(Rb) ~= length(intersect(Rb,Rc)) && length(Rb) >= 2;
            [Oskeleton,SADAcell] = RCP_Opt_Main( data(:, Rb),data,Oskeleton,Rb,SADAcell,skeleton,Ds_Temp,t);
        end
        if length(Rc) >= 2;
        [Oskeleton,SADAcell] = RCP_Opt_Main( data(:, Rc),data,Oskeleton,Rc,SADAcell,skeleton,Ds_Temp,t);
        end
    end
end






