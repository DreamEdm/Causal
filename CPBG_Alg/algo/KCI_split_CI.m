function Cskeleton = KCI_split_CI(data,idx,Now_skeleton,consetNum,Ds_order)
n = size(data,2);
Cskeleton = Now_skeleton;
alpha = 0.05;
for i= 1:(n-1)
    for j = i+1
        flag = true;
        if  Cskeleton(idx(i),idx(j))==0
            continue;
        end
            M = Cskeleton(:,idx(i)) +  Cskeleton(:,idx(j));
            Paij = find(M > 0)';
            s = 1:n;
            s([i,j]) = [];
            temp = intersect(idx(s),Paij);
            conSepSet = [];
            for p = 1:length(temp)
                conSepSet = [conSepSet,find(idx == temp(p))];
            end
%             M = 1:n;
%             M([i,j]) = [];
%             conSepSet = M; % Z = V-[i,j]
            if ~isempty(conSepSet) && length(conSepSet) > Ds_order % && length(conSepSet) > Ds_order 20200306
                for  k = Ds_order + 1:min(consetNum,length(conSepSet))
                    if flag == false
                        break;
                    end
                    condPaAll = nchoosek(conSepSet,k);
                    numCondPaAll = size(condPaAll,1);
                    for p = 1:numCondPaAll
                        condPa = condPaAll(p,:);
%                         [i,0,j,0,condPa]
                        ind =  KCIT(data(:,i), data(:,j), data(:, condPa),[]);
                        if ind
                            Cskeleton(idx(i),idx(j))=0;
                            Cskeleton(idx(j),idx(i))=0;
                            flag = false;
                            break;
                        end
                    end
                end
            end
%         else
%             Cskeleton(idx(i),idx(j))=0;
%             Cskeleton(idx(j),idx(i))=0;
%         end
    end
end
