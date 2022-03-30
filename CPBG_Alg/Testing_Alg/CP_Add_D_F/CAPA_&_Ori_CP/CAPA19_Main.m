function [Oskeleton,SADAcell] = CAPA19_Main(X,data,Cskeleton,idx,SADAcell,skeleton,Ds_Temp,t)
t = t + 1;
Oskeleton = Cskeleton;
[n,d]=size(X);
if d <= max(floor(size(Cskeleton,1)/10),3) || t > 6 %adaptive threshold for basic sovler
    SADAcell{size(SADAcell,2)+1} = idx;
else
    [idxA,idxB,idxCut ,Pa,Pb,Pc]=CAPA19_Split(X,Ds_Temp,idx); % RCP_Split_final RCP_Opt_Split
    Ra = idx(find(Pa == 1)');
    Rb = idx(find(Pb == 1)');
    Rc = idx(find(Pc == 1)');
    
    if sum(idxA)==0 || sum(idxB)==0 || size(X,2) == sum(Pc)
%         SADAcell{size(SADAcell,2)+1} = {unique([Ra,Rb,Rc])};
        if sum(idxA) ~=0
            SADAcell{size(SADAcell,2)+1} = Ra;
        end
        if sum(idxB) ~=0
            SADAcell{size(SADAcell,2)+1} = Rb;
        end
        if sum(idxCut) ~=0
            SADAcell{size(SADAcell,2)+1} = Rc;
        end
    else
        if length(Ra) ~= length(intersect(Ra,Rc)) && length(Ra) >= 2
            [Oskeleton,SADAcell] = CAPA19_Main( data(:, Ra),data,Oskeleton,Ra,SADAcell,skeleton,Ds_Temp,t);
        end
        if length(Rb) ~= length(intersect(Rb,Rc)) && length(Rb) >= 2
            [Oskeleton,SADAcell] = CAPA19_Main( data(:, Rb),data,Oskeleton,Rb,SADAcell,skeleton,Ds_Temp,t);
        end
        if length(Rc) >= 2
        [Oskeleton,SADAcell] = CAPA19_Main( data(:, Rc),data,Oskeleton,Rc,SADAcell,skeleton,Ds_Temp,t);
        end
    end
end






