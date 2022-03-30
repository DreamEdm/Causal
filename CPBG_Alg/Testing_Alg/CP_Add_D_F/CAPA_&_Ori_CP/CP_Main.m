function [Oskeleton,SADAcell] = CP_Main(X,data,Cskeleton,idx,SADAcell,skeleton,Ds_Temp,k)
k = k + 1;
Oskeleton = Cskeleton;
[n,d]=size(X);
if d <= max(floor(size(Cskeleton,1)/10),3) %|| k > 5%adaptive threshold for basic sovler

    SADAcell{size(SADAcell,2)+1} = {idx};
else
    [idxA,idxB,idxCut ,Pa,Pb,Pc]=CP_Split_final(X,Ds_Temp,idx); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 20190105
    ida = find(Pa == 1)';
    idb = find(Pb == 1)';
    idc = find(Pc == 1)';
    ida = unique([ida,idc]);
    idb = unique([idb,idc]);
    Ra = idx(ida);
    Rb = idx(idb);
    if sum(idxA)==0 || sum(idxB)==0 || size(X,2) == length(Ra) || size(X,2) == length(Rb)
        SADAcell{size(SADAcell,2)+1} = {unique([Ra,Rb])};
    else
        if length(Ra) >= 2;
            [Oskeleton,SADAcell] = RCP_Main( data(:, Ra),data,Oskeleton,Ra,SADAcell,skeleton,Ds_Temp,k);
        end
        if length(Rb) >= 2;
            [Oskeleton,SADAcell] = RCP_Main( data(:, Rb),data,Oskeleton,Rb,SADAcell,skeleton,Ds_Temp,k);
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 20190105





