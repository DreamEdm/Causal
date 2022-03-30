function [Ind_Temp] = find_Ds_Temp012(data,orderNum)
node = size(data,2);
Ind_Temp = zeros(node,node);
% tic;
for i = 1:node
    for j = 1: node
        if i ~= j
            indResult = PaCoTest(data(:,i), data(:,j),[],0.05);
            Ind_Temp(i,j) = indResult;
            Ind_Temp(j,i) = indResult;
        end
    end
end

Ds_Temp0 = Ind_Temp; % 0-order CI table
% toc;
if orderNum == 0
    return;
end

for i  = 1:node-1
    flag = true;
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0 && flag
            for k = 1:node
                if i ~= k && j ~= k
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                        flag = false;
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
    flag2 = true;
    for j = i+1:node
%         aaaaaaaa = [i,j]
%         Ind_Temp(i,j)
%         Ind_Temp(j,i)
%         flag2
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0 && flag2
            idx = unique(intersect(find(Ind_Temp(i,:) == 1), find(Ind_Temp(j,:) == 1)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
%             C
            if length(C) >= 2
                M = nchoosek(C,2);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                        flag2 = false;
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

for i  = 1:node-1
    flag3 = true;
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0 && flag3
            idx = unique(intersect(find(Ind_Temp(i,:) == 1), find(Ind_Temp(j,:) == 1)));
            idx = [idx,i,j];
            C = 1:node;
            C(idx) = [];
            if length(C) >= 3
                M = nchoosek(C,3);
                for k = 1:size(M,1)
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        break;
                        flag3 = false;
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