function [Ind_Temp,Acell] = find_Ds_Temp_Cell_fast(data,orderNum)
node = size(data,2);
Acell = cell(4,1);
p = 1;
Acell{1,p} = 0;
Acell{2,p} = 0;
Acell{3,p} = 0;
Acell{4,p} = 0;
Ind_Temp = zeros(node,node);
%---------------------------------------------------------------------
t = 1;
%---------------------------------------------------------------------
for i = 1:node-1
    for j = i+1: node
        indResult = PaCoTest(data(:,i), data(:,j),[],0.05);
        if indResult
            Ind_Temp(i,j) = 1;
            Ind_Temp(j,i) = 1;
            Acell{1,t} = [i,j];
            Acell{2,t} = 0; % d set
            Acell{3,t} = 0; % ×ó
            Acell{4,t} = 0; % ÓÒ
            t = t + 1;
        end
    end
end

Ds_Temp0 = Ind_Temp; % 0-order CI table

if orderNum == 0
    return;
end
%---------------------------------------------------------------------
for i  = 1:node-1
    for j = i+1:node
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0 
            for k = 1:node
                if i ~= k && j ~= k && Ind_Temp(i,k) == 0 && Ind_Temp(j,k) == 0
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),0.05);
                    if ind
                        Ind_Temp(i,j) = 1;
                        Ind_Temp(j,i) = 1;
                        Acell{1,t} = [i,j];
                        Acell{2,t} = k; % d set
                        Acell{3,t} = 0; % ×ó
                        Acell{4,t} = 0; % ÓÒ
                        %---------------------------------------------------------------------
                        x = data(:,i);
                        y = data(:,j);
                        z = data(:, k);
                        res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
                        res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
                        ind2 = PaCoTest(res1,data(:,k),[],0.05);
                        ind3 = PaCoTest(res2,data(:,k),[],0.05);
                        if ind2
                            Acell{3,t} = k; % ×ó
                        end
                        if ind3
                            Acell{4,t} = k; % ÓÒ
                        end
                        %---------------------------------------------------------------------
                        t = t + 1;
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
%---------------------------------------------------------------------
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
                        Acell{1,t} = [i,j];
                        Acell{2,t} = M(k,:); % d set
                        Acell{3,t} = 0; % ×ó
                        Acell{4,t} = 0; % ÓÒ
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
                            Acell{3,t} = M(k,:); % ×ó
                        end
                        if ind3
                            Acell{4,t} = M(k,:); % ÓÒ
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         t = t + 1;
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
                        Acell{1,t} = [i,j];
                        Acell{2,t} = k; % d set
                        Acell{3,t} = 0; % ×ó
                        Acell{4,t} = 0; % ÓÒ
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
                            Acell{3,t} = M(k,:); % ×ó
                        end
                        if ind3
                            Acell{4,t} = M(k,:); % ÓÒ
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         t = t + 1;
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