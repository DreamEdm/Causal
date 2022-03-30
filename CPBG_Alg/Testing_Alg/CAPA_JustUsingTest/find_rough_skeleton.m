function Ind_Temp = find_rough_skeleton(data,orderNum)
node = size(data,2);
MN = nchoosek(1:node,2);
Ind_Temp = ones(node,node)-eye(node,node);
%---------------------------------------------------------------------
for i = 1:node-1
    for j = i+1: node
        indResult = PaCoTest(data(:,i), data(:,j),[],0.05);
        if indResult
            Ind_Temp(i,j) = 0;
            Ind_Temp(j,i) = 0;
        end
    end
end

Ds_Temp0 = Ind_Temp; % 0-order CI table

if orderNum == 0
    return;
end

%---------------------------------------------------------------------
% tic
for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 1 && Ind_Temp(j,i) == 1 
            for k = 1:node
                if i ~= k && j ~= k && Ind_Temp(i,k) == 1 && Ind_Temp(j,k) == 1
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),0.05);
                    if ind
                        Ind_Temp(i,j) = 0;
                        Ind_Temp(j,i) = 0;
                        break;
                    end
                end
            end
        end
    end
end
% toc
Ds_Temp1 = Ind_Temp; % 1-order CI table
% toc;

if orderNum == 1
    return;
end
%---------------------------------------------------------------------
for i = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 1 && Ind_Temp(j,i) == 1 
            idx = unique(intersect(find(Ind_Temp(i,:) == 0), find(Ind_Temp(j,:) == 0)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
            if length(C) >= 2
                M = nchoosek(C,2);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 0;
                        Ind_Temp(j,i) = 0;             
                        break;
                    end
                end
            end
        end
    end
end
% 
Ds_Temp2 = Ind_Temp; % 2-order CI table
% toc;

if orderNum == 2
    return;
end
%---------------------------------------------------------------------
for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 1 && Ind_Temp(j,i) == 1 
            idx = unique(intersect(find(Ind_Temp(i,:) == 0), find(Ind_Temp(j,:) == 0)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
            if length(C) >= 3
                M = nchoosek(C,3);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 0;
                        Ind_Temp(j,i) = 0;
                        break;
                    end
                end
            end
        end
    end
end
% 
Ds_Temp3 = Ind_Temp; % 2-order CI table
% toc;
end