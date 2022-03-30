function Cskeleton = KCI_split_linear_CP(data,idx,Now_skeleton,consetNum)
n = size(data,2);
Cskeleton = Now_skeleton;
alpha = 0.05;
for i= 1:(n-1)
    for j = i+1:n
        flag = true;
        if  Cskeleton(idx(i),idx(j))==0
            continue;
        end
        [indf,~] = PartialCorreTest(data(:,i), data(:,j),[],alpha);
        if indf == false
            temp = (1:n);
            A = find(Cskeleton(idx(i),:) == 0);
            B = find(Cskeleton(idx(j),:) == 0);
            C = unique(intersect(A,B));
            [~,D] = intersect(idx(temp),C);
            temp(unique([i,j,D']))=[];
            %%%%%%%%%%%%%%%%%%%%%%%%%%%Ds_Temp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            conSepSet = temp;
            if ~isempty(conSepSet)
                for k=1:min(consetNum,length(conSepSet))
                    if flag == false
                        break;
                    end
                    condPaAll = nchoosek(temp,k);
                    numCondPaAll = size(condPaAll,1);
                    for p = 1:numCondPaAll
                        condPa = condPaAll(p,:);
                        [ind,~]  =   PartialCorreTest(data(:,i), data(:,j), data(:, condPa),alpha);
                        if ind
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            x = data(:,i);
                            y = data(:,j);
                            z = data(:, k);
                            res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                            res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                            ind2 = PaCoTest(res1,data(:,condPa(1)),[],0.05);
                            ind3 = PaCoTest(res2,data(:,condPa(1)),[],0.05);
                            if ind2
                                Cskeleton(idx(i),idx(condPa))=0;
                            end
                            if ind3
                                Cskeleton(idx(j),idx(condPa))=0;
                            end
                            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            Cskeleton(idx(i),idx(j))=0;
                            Cskeleton(idx(j),idx(i))=0;
                            flag = false;
                            break;
                        end
                    end
                end
            end
        else
            Cskeleton(idx(i),idx(j))=0;
            Cskeleton(idx(j),idx(i))=0;
        end
    end
end