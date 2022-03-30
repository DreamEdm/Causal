function [Ind_Temp,Acell,Bcell,Ccell] = find_Ds_Temp_Cell(data,orderNum)
node = size(data,2);
Acell = cell(1,node);
Bcell = cell(1,node);
Ccell = cell(1,node);
MN = nchoosek(1:node,2);
for p = 1:size(MN,1)
    Acell{p}=-1;
    Bcell{p}=-1;
    Ccell{p}=-1;
end
Ind_Temp = zeros(node,node);

for i = 1:node-1
    for j = i+1: node
        indResult = PaCoTest(data(:,i), data(:,j),[],0.05);
        if indResult
            Ind_Temp(i,j) = 1;
            Ind_Temp(j,i) = 1;
            indTemp = find(ismember(MN, sort([i,j]), 'rows')==1);
            Acell{indTemp} = 0;
            Bcell{indTemp}=0; % ×ó
            Ccell{indTemp}=0; % ÓÒ
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
                if i ~= k && j ~= k && Ind_Temp(i,k) == 0 && Ind_Temp(j,k) == 0   %%%%%%%%% ¼ÓÁË¸öÅÐ¶Ïk 20200304
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        indTemp = find(ismember(MN, sort([i,j]), 'rows')==1);
                        Acell{indTemp} = k;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        x = data(:,i);
                        y = data(:,j);
                        z = data(:, k);
                        res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                        res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                        ind2 = PaCoTest(res1,data(:,k),[],0.05);
                        ind3 = PaCoTest(res2,data(:,k),[],0.05);
                        if ind2
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Bcell{indTemp} = k;
                        end
                        if ind3
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Ccell{indTemp} = k;
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
% tttttttttttttttttttttttttttttttttt
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
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        indTemp = find(ismember(MN, sort([i,j]), 'rows')==1);
                        Acell{indTemp} = M(k,:);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        x = data(:,i);
                        y = data(:,j);
                        z = data(:, M(k,:));
                        res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                        res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                        condPa = M(k,:);
                        for w1 = 1:length(condPa)
                            ind2 = PaCoTest(res1,data(:,condPa(w1)),[],0.05);
                            if ind2 == false
                                break;
                            end
                        end
                        for w2 = 1:length(condPa)
                            ind3 = PaCoTest(res2,data(:,condPa(w2)),[],0.05);
                            if ind3 == false
                                break;
                            end
                        end
                        if ind2
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Bcell{indTemp} = M(k,:);
                        end
                        if ind3
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Ccell{indTemp} = M(k,:);
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    ind = PaCoTest(data(:,i), data(:,j),data(:,M(k,:)),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        indTemp = find(ismember(MN, sort([i,j]), 'rows')==1);
                        Acell{indTemp} = M(k,:);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        x = data(:,i);
                        y = data(:,j);
                        z = data(:, M(k,:));
                        res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                        res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                        condPa = M(k,:);
                        for w1 = 1:length(condPa)
                            ind2 = PaCoTest(res1,data(:,condPa(w1)),[],0.05);
                            if ind2 == false
                                break;
                            end
                        end
                        for w2 = 1:length(condPa)
                            ind3 = PaCoTest(res2,data(:,condPa(w2)),[],0.05);
                            if ind3 == false
                                break;
                            end
                        end
                        if ind2
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Bcell{indTemp} = M(k,:);
                        end
                        if ind3
                            indTemp = find(ismember(MN, [i,j], 'rows')==1);
                            Ccell{indTemp} = M(k,:);
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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