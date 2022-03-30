function Cskeleton = PC_skeleton_CPD(data,idx,Now_skeleton,consetNum)
data = data(:,idx);
Ds_order = 2; % size of Z during find_rough_skeleton
n = size(data,2);
Cskeleton = Now_skeleton;
alpha = 0.05;
for i= 1:(n-1)
    for j = i+1:n
        flag = true;
        if  Cskeleton(idx(i),idx(j))==0
            continue;
        end
        M = Cskeleton(:,idx(i)) +  Cskeleton(:,idx(j)); % Z = neighbors of i and j
        Paij = find(M > 0)';
        s = 1:n;
        s([i,j]) = [];
        temp = intersect(idx(s),Paij);
        conSepSet = [];
        for p = 1:length(temp)
            conSepSet = [conSepSet,find(idx == temp(p))];
        end
        if ~isempty(conSepSet) && length(conSepSet) > Ds_order 
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