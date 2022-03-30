function Cskeleton = PC_skeleton_CAPA(data,idx,Now_skeleton,consetNum)
data = data(:,idx);
Ds_order = 2;
n = size(data,2);
Cskeleton = Now_skeleton;
alpha = 0.05;
for i= 1:(n-1)
    for j = i+1:n
        flag = true;
        if  Cskeleton(idx(i),idx(j))==0
            continue;
        end
        M = 1:n;
        M([i,j]) = [];
        conSepSet = M; % Z = V-[i,j]
        if ~isempty(conSepSet) && length(conSepSet) > Ds_order % && length(conSepSet) > Ds_order 20200306
            for  k = Ds_order + 1:min(consetNum,length(conSepSet))
                if flag == false
                    break;
                end
                condPaAll = nchoosek(conSepSet,k);
                numCondPaAll = size(condPaAll,1);
                for p = 1:numCondPaAll
                    condPa = condPaAll(p,:);
                    ind  =   PaCoTest(data(:,i), data(:,j), data(:, condPa),alpha);
                    if ind
                        Cskeleton(idx(i),idx(j))=0;
                        Cskeleton(idx(j),idx(i))=0;
                        flag = false;
                        break;
                    end
                end
            end
        end
    end
end