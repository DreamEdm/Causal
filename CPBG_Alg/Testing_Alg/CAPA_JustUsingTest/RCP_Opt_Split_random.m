function [idxA,idxB,idxCut,Pa,Pb,Pc]=RCP_Opt_Split_random(X,Ds_Temp,idxGloble)
[~, nNode]=size(X);
[idxA,idxB,idxCut,Pa,Pb,Pc]=Opt_Split_Basic(X(:, 1:nNode),Ds_Temp,idxGloble(1:nNode));
end

function [idxA,idxB,idxCut,Pa,Pb,Pc]=Opt_Split_Basic(X,Ds_Temp,idxNow)
[~, nNode]=size(X);
idxA=false(nNode, 1);
idxB=false(nNode, 1);
idxCut=true(nNode, 1);
%%%%%%initial%%%%%%%%%%%%%%%%%%%%%%
Ds = false(nNode,nNode);
for i = 1:nNode
    for j = 1:nNode
        Ds(i,j) = Ds_Temp(idxNow(i),idxNow(j));
    end
end
DsHold = Ds;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
skeleton = zeros(nNode,nNode);

for i = 1:nNode
    for j = 1:nNode
        if Ds(i,j) == 0
            skeleton(i,j) = 1;
        end
    end
end

n = size(skeleton,1);
A = skeleton;
for i = 1:n
    A(i,i) = 0; %%%%%%%%%%%%%%%%%%%%%% neccesary
    for j = 1:n
        if skeleton(i,j) >= 1
            A(j,i) = skeleton(i,j);
        end
    end
end
skeleton = A;

% graphViz4Matlab(skeleton)

V1 = [];
V2 = [];
terFlag = 1;
C = [1:n;1:n];
sequenceID = 1;
C2 = C;
A2 = A;
stoptimes = 0;

% times = 0;
while terFlag == 1 && stoptimes < 3
%     times = times + 1
    L = PrimMax(A);
    a = L(1);
    b = L(2);
    idxb = find(C(2,:) == b);
    bReal = C(1,idxb);
%     CCCCCCCCCCCCCCC = C
%         SumSum = sum(sum(skeleton(V1,V2)))
%     if sum(sum(skeleton(V1,V2))) > 0 
%         sdfsdfsdfsdfsdf
%     end
%     LLbRealsequenceID = [L(1),L(2),bReal,sequenceID]
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if sequenceID == 2
        sequenceID = 1;
        
%         sssssssssaaaa = skeleton(bReal,V1)
%         sssssssssssss = sum(skeleton(bReal,V1))
%         aaaaaaaaaaaaa = a
        if sum(skeleton(bReal,V1)) > 0 || a == 1%%% 若候选V2与V1已经相连
%             q = 1:n;
[~,q] = sort(sum(Ds),'descend');
            addFlag1 = 0;
            addFlag2 = 0;
            for k = 1:n               %% 找出潜在b
                if sum(skeleton(q(k),V1))==0  && isempty(intersect(q(k),[V1,V2])) && C(2,q(k))~=1
                    b = C(2,q(k));
%                     b
%                     C
                    addFlag1 = 1;
                    break;
                end
            end
            if addFlag1 == 1
                for j = 1:n               %% 找出潜在a
                    if sum(skeleton(q(j),V1))==0 && q(j) ~= q(k)  && isempty(intersect(q(j),[V1,V2])) && C(2,q(j))~=1
                        a = C(2,q(j));
%                         a
%                         C
                        addFlag2 = 1;
                        break;
                    end
                end
            end
            if addFlag1 == 1 && addFlag2 == 1 %% 若ab存在 则V2新增
%                 ab11111111111111 = [a,b]
%                 SumSum111 = sum(sum(skeleton(V1,V2)))
%                 skeleton(V1,q(k))
%                 ssssum = sum(skeleton(q(k),V1))
                V2 = [V2,q(k)];
%                 SumSum222 = sum(sum(skeleton(V1,V2)))
%                 if sum(sum(skeleton(V1,V2))) > 0
%                     sadfasdasdadasdsad111111111111111
%                 end
                stoptimes = 0;
            else
                sequenceID = 2;
                C = C2; %%%%%%%% hold
                A = A2; %%%%%%%% hold
                stoptimes = stoptimes + 1;
                continue;
            end
        else
            V2 = [V2,bReal];
%             SumSum = sum(sum(skeleton(V1,V2)))
%             if sum(sum(skeleton(V1,V2))) > 0
%                 sadfasdasdadasdsad222222222222222
%             end
            stoptimes = 0;
        end
    else
        sequenceID = 2;
        if sum(skeleton(bReal,V2)) > 0 %%% 若候选V1与V2已经相连
%             q = 1:n;
[~,q] = sort(sum(Ds),'descend');   %%%%%%% q = 随机、原有顺序、降序 三种排序方案，哪个最好不能一概而论
            addFlag1 = 0;
            addFlag2 = 0;
            for k = 1:n               %% 找出潜在b
                if sum(skeleton(q(k),V2))==0 && isempty(intersect(q(k),[V1,V2])) && C(2,q(k))~=1
                    b = C(2,q(k));
%                     b
%                     C
                    addFlag1 = 1;
                    break;
                end
            end
            if addFlag1 == 1
                for j = 1:n               %% 找出潜在a
                    if sum(skeleton(q(j),V2))==0 && q(j) ~= q(k)  && isempty(intersect(q(j),[V1,V2])) && C(2,q(j))~=1
                        a = C(2,q(j));
%                         a
%                         C
                        addFlag2 = 1;
                        break;
                    end
                end
            end
            if addFlag1 == 1 && addFlag2 == 1 %% 若ab存在 则V1新增
                V1 = [V1,q(k)];
%                 SumSum = sum(sum(skeleton(V1,V2)))
%                 if sum(sum(skeleton(V1,V2))) > 0
%                     sadfasdasdadasdsad33333333333333
%                 end
                stoptimes = 0;
            else
                sequenceID = 1;
                C = C2; %%%%%%%% hold
                A = A2; %%%%%%%% hold
                stoptimes = stoptimes + 1;
                continue;
            end
        else
            V1 = [V1,bReal];
%             SumSum = sum(sum(skeleton(V1,V2)))
%             if sum(sum(skeleton(V1,V2))) > 0
%                 sadfasdasdadasdsad4444444444444
%             end
            stoptimes = 0;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    idxa = find(C(2,:) == a);
    idxb = find(C(2,:) == b);
    idx1 = find(C(2,:) == 1);
    
%     ab1 = [a,b]
    
    C(2,idxb) = 0;
    C(2,find(C(2,:)>b)) = C(2,find(C(2,:)>b)) - 1;
%     AA = A
%     bb = b
    A(:,b) = [];
    A(b,:) = [];
    C2 = C; %%%%%%%% hold
    A2 = A; %%%%%%%% hold
    if a > b
        a = a - 1;
    end
    C(2,idx1) = a;
    C(2,idxa) = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:size(A,1) %%%%%%%%%%%%%%%%%%%%%% neccesary !
        A(i,i) = 0;
    end
    tempA = A;
    
%     ab2 = [a,b]
    
    A(a,:) = tempA(1,:);
    A(1,:) = tempA(a,:);
    A(:,a) = tempA(:,1);
    A(:,1) = tempA(:,a);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if length(V1) + length(V2) >= n-1
        terFlag = 0;
    end
end

% stoptimesaaaa = stoptimes
% terFlaaaaaaaaaaaaaag = terFlag

T1 = [];

if length(V1) > length(V2) + 1
    for i = 1:length(V1)
        if sum(skeleton(V1(i),V1)) == 1
            T1 = [T1,V1(i)];
        end
        if  length(V1) <= length(V2) + 2*length(T1)
            break
        end
    end
    V1 = setdiff(V1,T1);
    V2 = [V2,T1];
end

if length(V2) > length(V1) + 1
    for i = 1:length(V2)
        if sum(skeleton(V2(i),V2)) == 1
            T1 = [T1,V2(i)];
            iterF = 0;
        end
        if  length(V2) <= length(V1) + 2*length(T1)
            break
        end
    end
    V2 = setdiff(V2,T1);
    V1 = [V1,T1];
end

idxA(V1) = 1;
idxB(V2) = 1;
idxCut = true(nNode, 1) - idxA - idxB;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idxC = true(nNode, 1);
TempAB = [find(idxA == true)',find(idxB == true)'];
TempC = find(idxCut == true)';
for i = 1:length(TempAB)
    if sum(DsHold(TempAB(i),TempC)) == length(TempC)
        idxC(TempAB(i)) = false;
    end
end

Pa = idxA + idxCut;
Pb = idxB + idxCut;
Pc = idxC;

end

function L = PrimMax(A)
n = size(A,1);
A = A+A';
A(A==0) = Inf;
P = zeros(1, n);
P(1,1) = 1;
V = 1:n;
V_P = V - P;
link = zeros(n-1,2);
k=1;
while k<n
    p = P(P~=0);
    v = V_P(V_P~=0);
    pv = min(min(A(p,v)));
    [x, y] = find(A==pv);
    for i = 1:length(x)
        if  any(P==x(i)) && any(V_P==y(i))
            P(1,y(i)) = y(i);
            V_P = V - P;
            link(k, :) = [x(i), y(i)];
            k = k+1;
            break;
        end
    end
end
% link
L = link(end,:);
end