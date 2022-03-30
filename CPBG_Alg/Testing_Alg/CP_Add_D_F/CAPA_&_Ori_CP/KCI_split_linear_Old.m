function Cskeleton = KCI_split_linear_Old(data,idx,Now_skeleton,consetNum,Ds_order)
n = size(data,2);
Cskeleton = Now_skeleton;
alpha = 0.05;
for i= 1:(n-1)
    for j = i+1:n
        flag = true;
        if  Cskeleton(idx(i),idx(j))==0
            continue;
        end
%         [indf,~] = PartialCorreTest(data(:,i), data(:,j),[],alpha);  
%         if indf == false
            temp = (1:n);
            A = find(Cskeleton(idx(i),:) == 0);
            B = find(Cskeleton(idx(j),:) == 0);
            C = unique(intersect(A,B));
%             M = Cskeleton(idx(i),:) +  Cskeleton(idx(j),:);
%             C = find(M == 0);
            
            [~,D] = intersect(idx(temp),C);
            temp(unique([i,j,D']))=[];
%              temp(unique([i,j]))=[];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Ds_Temp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            conSepSet = temp;
            if ~isempty(conSepSet) && length(conSepSet) > Ds_order % && length(conSepSet) > Ds_order 20200306
                for  k = Ds_order + 1:min(consetNum,length(conSepSet))
                    if flag == false
                        break;
                    end
                    condPaAll = nchoosek(temp,k);
                    numCondPaAll = size(condPaAll,1);
                    for p = 1:numCondPaAll
                        condPa = condPaAll(p,:);
                        [ind,~]  =   PartialCorreTest(data(:,i), data(:,j), data(:, condPa),alpha);
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