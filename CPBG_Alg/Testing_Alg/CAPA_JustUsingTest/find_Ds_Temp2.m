function [Ind_Temp,AM,BM,CM,DM] = find_Ds_Temp2(data,orderNum)
node = size(data,2);
MN = nchoosek(1:node,2);
Lmn = size(MN,1);
AM = zeros(2,Lmn);
BM = zeros(3,Lmn);
CM = zeros(3,Lmn);
DM = zeros(3,Lmn);
Ind_Temp = zeros(node,node);
m = size(data,1);
m
if m > 100
    m = 100;
end
%---------------------------------------------------------------------
t = 1;
%---------------------------------------------------------------------

for i = 1:node-1
    for j = i+1: node
        indResult = PaCoTest(data(:,i), data(:,j),[],0.05);
        if indResult
            Ind_Temp(i,j) = 1;
            Ind_Temp(j,i) = 1;
            AM([1,2],t) = [i,j]; 
            t = t + 1;
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
        if Ind_Temp(i,j) == 0 && Ind_Temp(j,i) == 0 
            for k = 1:node
                if i ~= k && j ~= k && Ind_Temp(i,k) == 0 && Ind_Temp(j,k) == 0
                    ind = PaCoTest(data(:,i), data(:,j),data(:,k),0.05);
                    if ind
%                         Ind_Temp(i,j) = 1;
%                         Ind_Temp(j,i) = 1;
%                         AM([1,2],t) = [i,j]; 
                        BM(1,t) = k; 
%                         %---------------------------------------------------------------------
%                             x = data(1:m,i);
%                             y = data(1:m,j);
%                             z = data(1:m, k);
%                         res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
%                         res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
%                         ind2 = KCIT(res1,data(1:m,k),[],[]);
%                         ind3 = KCIT(res2,data(1:m,k),[],[]);
%                         if ind2
                            CM(1,t) = k; % ×ó
%                         end
%                         if ind3
                            DM(1,t) = k; % ÓÒ
%                         end
%                         %---------------------------------------------------------------------
%                         t = t + 1;
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
%                         Ind_Temp(i,j) = 1;
%                         Ind_Temp(j,i) = 1;             
%                         AM([1,2],t) = [i,j];
%                         BM([1,2],t) = M(k,:);
%                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             x = data(1:m,i);
%                             y = data(1:m,j);
%                             z = data(1:m, M(k,:));
%                         res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
%                         res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
%                         condPa = M(k,:);
%                         for w1 = 1:length(condPa)
%                               ind2 = KCIT(res1,data(1:m,condPa(w1)),[],[]);
%                             if ind2 == false
%                                 break;
%                             end
%                         end
%                         for w2 = 1:length(condPa)
%                             ind3 = KCIT(res2,data(1:m,condPa(w2)),[],[]);
%                             if ind3 == false
%                                 break;
%                             end
%                         end
%                         if ind2
                            CM([1,2],t) = M(k,:); % ×ó
%                         end
%                         if ind3
                            DM([1,2],t) = M(k,:); % ÓÒ
%                         end
%                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          t = t + 1;
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
%                         Ind_Temp(i,j) = 1;
%                         Ind_Temp(j,i) = 1;
%                         AM([1,2],t) = [i,j];
%                         BM([1:3],t) = M(k,:);
%                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             x = data(1:m,i);
%                             y = data(1:m,j);
%                             z = data(1:m, M(k,:));
%                         res1 = (eye(size(x,1))-z*((z'*z)^-1)*z')*x;
%                         res2 = (eye(size(y,1))-z*((z'*z)^-1)*z')*y;
%                         condPa = M(k,:);
%                         for w1 = 1:length(condPa)
%                             ind2 = KCIT(res1,data(1:m,condPa(w1)),[],[]);
%                             if ind2 == false
%                                 break;
%                             end
%                         end
%                         for w2 = 1:length(condPa)
%                             ind3 = KCIT(res2,data(1:m,condPa(w2)),[],[]);
%                             if ind3 == false
%                                 break;
%                             end
%                         end
%                         if ind2
                            CM([1:3],t) = M(k,:); % ×ó
%                         end
%                         if ind3
                            DM([1:3],t) = M(k,:); % ÓÒ
%                         end
%                         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          t = t + 1;
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