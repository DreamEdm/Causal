function [Oskeleton,SADAcell] = CAPA_Main(X,data,Cskeleton,idx,SADAcell,skeleton,Ds_Temp,k)
k = k + 1;
Oskeleton = Cskeleton;
[n,d]=size(X);
if d <= max(floor(size(Cskeleton,1)/10),3) || k > 8%adaptive threshold for basic sovler
        SADAcell{size(SADAcell,2)+1} = [idx]; 
else
    [idxA,idxB,idxCut ,Pa,Pb,Pc]=CAPA_Split(X,Ds_Temp,idx);  %%%%%%% CAPA_Split �� CAPA19_Split
    ida = find(Pa == 1)';
    idb = find(Pb == 1)';
    idc = find(Pc == 1)';
    %-------------------------------- 20200306
    idxA = idx(ida);
    idxB = idx(idb);
    idxC = idx(idc);
    %-------------------------------- 20200306
    % 保留了D分离集
    ida = unique([ida,idc]);
    idb = unique([idb,idc]);
    Ra = idx(ida);
    Rb = idx(idb);
    %-------------------------------- 20200306
    % 无法分割检测，如果无法分割，直接存储值
    if sum(idxA)==0 || sum(idxB)==0 || size(X,2) == length(Ra) || size(X,2) == length(Rb) %size(X,2) == sum(Pc)
%                 SADAcell{size(SADAcell,2)+1} = unique([Ra,Rb]);% 20200306
        if sum(idxA) ~=0
            SADAcell{size(SADAcell,2)+1} = [idxA];
        end
        if sum(idxB) ~=0
            SADAcell{size(SADAcell,2)+1} = [idxB];
        end
        if sum(idxC) ~=0
            SADAcell{size(SADAcell,2)+1} = [idxC];
        end
%     elseif size(X,2) == length(Ra) || size(X,2) == length(Rb)
%         if length(idxA) ~= length(intersect(idxA,idxC)) && length(idxA) >= 2
%             [Oskeleton,SADAcell] = CAPA_Main( data(:, idxA),data,Oskeleton,idxA,SADAcell,skeleton,Ds_Temp,k);
%         end
%         if length(idxB) ~= length(intersect(idxB,idxC)) && length(idxB) >= 2
%             [Oskeleton,SADAcell] = CAPA_Main( data(:, idxB),data,Oskeleton,idxB,SADAcell,skeleton,Ds_Temp,k);
%         end
%         if length(idxC) >= 2
%             [Oskeleton,SADAcell] = CAPA_Main( data(:, idxC),data,Oskeleton,idxC,SADAcell,skeleton,Ds_Temp,k);
%         end
    else
        if length(Ra) >= 2
            [Oskeleton,SADAcell] = CAPA_Main( data(:, Ra),data,Oskeleton,Ra,SADAcell,skeleton,Ds_Temp,k);
        end
        if length(Rb) >= 2
            [Oskeleton,SADAcell] = CAPA_Main( data(:, Rb),data,Oskeleton,Rb,SADAcell,skeleton,Ds_Temp,k);
        end
    end
    %-------------------------------- 20200306
end





