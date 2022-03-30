function [idxA,idxB,idxCut,Pa,Pb,Pc]=CP_Split_final(X,Ds_Temp,idxGloble)
[~, nNode]=size(X);
%     if length(intersect(idxGloble,[1     2     4     5     6     7    10    12    13    14    15    17    18    22    23    24    25    26 27    28    29    30    31    32    33    34    35    36    37])) == 29  && length(idxGloble) == 29
%         ccccccccccccc  = 1
%         [idxA,idxB,idxCut,Pa,Pb,Pc]=SADA_Split_Basic2(X(:, 1:nNode),Ds_Temp,idxGloble(1:nNode));
%     else
    [idxA,idxB,idxCut,Pa,Pb,Pc]=CP_Split_Basic(X(:, 1:nNode),Ds_Temp,idxGloble(1:nNode));
%     end
end

function [idxA,idxB,idxCut,Pa,Pb,Pc]=CP_Split_Basic(X,Ds_Temp,idxNow)
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
        % Ds是1的话就证明是独立的
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
% flag = true;
% maxIter = 1000000;
% while flag == true
%     Ds = Ds_Temp;
%     idA = find(idxA == 1)';
%     idB = find(idxB == 1)';
%     idC = find(idxCut == 1)';
%     flagContinue = true;
%     if length(idC)>= 2
%         minReplace = 1000;
%         iter = 0;
%         for k = 2:length(idC)
%             if flagContinue == false || iter > maxIter;
% %                 iter1 = iter
%                 break;
%             end
%             if k <= minReplace && minReplace ~= 1000
%                 continue;
%             end
%             MC = nchoosek(idC,k);
%             for i = 1:size(MC,1)
%                 iter = iter + 1;
%                 if iter > maxIter
% %                     iter2 = iter
%                     break;
%                 end
%                 tSet = MC(i,:);
%                 idxReplace = setdiff(1:length(idA),find(sum(DsHold(tSet,idA))==k));
%                 idxRepB = setdiff(1:length(idB),find(sum(DsHold(tSet,idB))==k));
%                 min2 = min(length(idxReplace),length(idxRepB));
%                 if min2 < minReplace
%                     minReplace = min2;
%                 end
%                 if sum(idxA)<sum(idxB)
%                     if length(idA) >=2 && length(idxReplace) < k
%                         idxA(idA(idxReplace)) = false;
%                         idxCut(tSet) = false;
%                         idxCut(idA(idxReplace)) = true;
%                         idxB(tSet) = true;
%                         flag = true;
%                         flagContinue = false;
% %                         ResultOutput2 = [sum(idxA),sum(idxB),sum(idxCut)]
%                         iter = 0;
%                         break;
%                     end
%                 else
%                     if length(idB) >=2 && length(idxRepB) < k
%                         idxB(idB(idxRepB)) = false;
%                         idxCut(tSet) = false;
%                         idxCut(idB(idxRepB)) = true;
%                         idxA(tSet) = true;
%                         flag = true;
%                         flagContinue = false;
% %                         ResultOutput3 = [sum(idxA),sum(idxB),sum(idxCut)]
%                         iter = 0;
%                         break;
%                     end
%                 end
%             end
%         end
%     end
%     if flagContinue == true
%         flag = false;
%     end
% end
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

end
