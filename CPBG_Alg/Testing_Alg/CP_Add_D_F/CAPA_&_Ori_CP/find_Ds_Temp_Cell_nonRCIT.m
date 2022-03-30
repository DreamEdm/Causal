function [Ind_Temp] = find_Ds_Temp_Cell_nonRCIT(data,orderNum)
node = size(data,2);
MN = nchoosek(1:node,2);
Ind_Temp = zeros(node,node);
alpha = 0.05;
for i = 1:node-1
    for j = i+1: node
        indResult = PaCoTest(data(:,i), data(:,j),[],alpha);
        if indResult
            Ind_Temp(i,j) = 1;
            Ind_Temp(j,i) = 1;
        end
    end
end

Ds_Temp0 = Ind_Temp; % 0-order CI table

if orderNum == 0
    return;
end

for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0
            for k = 1:node
                if i ~= k && j ~= k
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),alpha);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                    end
                end
            end
        end
    end
end

Ds_Temp1 = Ind_Temp; % 1-order CI table
% toc;

if orderNum == 1
    return;
end

for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0
            idx = unique(intersect(find(Ind_Temp(i,:) == 1), find(Ind_Temp(j,:) == 1)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
            if length(C) >= 2
                M = nchoosek(C,2);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),alpha);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                    end
                end
            end
        end
    end
end

Ds_Temp2 = Ind_Temp; % 2-order CI table

if orderNum == 2
    return;
end

for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0
            idx = unique(intersect(find(Ind_Temp(i,:) == 1), find(Ind_Temp(j,:) == 1)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
            if length(C) >= 3
                M = nchoosek(C,3);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),alpha);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                    end
                end
            end
        end
    end
end

Ds_Temp3 = Ind_Temp; % 3-order CI table

end