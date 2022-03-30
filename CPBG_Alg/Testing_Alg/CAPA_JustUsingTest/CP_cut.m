function [cut_set,nodeA,nodeB,nodeCD,r_s]=CP_cut(X)
r_s = find_rough_skeleton(X,2);
n = size(r_s,1);
Ds_Temp = ones(n,n)-r_s-eye(n,n);
idxGloble = 1:n;
[~, nNode]=size(X);
    [cut_set,nodeA,nodeB,nodeCD,Pa,Pb,Pc]=CAPA_Split_Basic(X(:, 1:nNode),Ds_Temp,idxGloble(1:nNode));
end

function [cut_set,nodeA,nodeB,nodeCD,Pa,Pb,Pc]=CAPA_Split_Basic(X,Ds_Temp,idxNow)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~,b] = max(sum(Ds));
idxA(b)=true;
DsHold = Ds;
for i=2:nNode
    Ds(:,idxA) = 0;
    Ds(:,idxB) = 0;
    for j = 2:nNode
        [p,q] = sort(sum(Ds),'descend');
        r = randperm(1);
        b = q(r(1));
        [~,b] = max(sum(Ds));
        Ds(:,b) = 0;
        if sum(idxA)>sum(idxB)
            if sum(DsHold(idxA,b)) == sum(idxA)
                idxB(b)=true;
                break;
            elseif sum(DsHold(idxB,b)) == sum(idxB)
                idxA(b)=true;
                break;
            end
        else
            if sum(DsHold(idxB,b)) == sum(idxB)
                idxA(b)=true;
                break;
            elseif sum(DsHold(idxA,b)) == sum(idxA)
                idxB(b)=true;
                break;
            end
        end
    end
end

for i = 1:nNode
    if idxA(i) == true || idxB(i) == true
        idxCut(i) = false;
    end
end
%--------------------------------------------------------------------------

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
cut_set = (find(idxCut==1))';
nodeCD = (find(Pc==1))';
nodeA = (find(idxA==1))';
nodeB = (find(idxB==1))';
end
