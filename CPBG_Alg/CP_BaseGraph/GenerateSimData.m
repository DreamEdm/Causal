function [SimSkeleton, names] = GenerateSimData(nNode, nFreeNode, nIndegree)
    if nIndegree > nFreeNode
        disp('Cannot let nIndegree larger than nFreeNode!');
        return;
    end
    % Because we use the "name" as the index of our algorithm execution, 
    % for the virtual data set, we introduce the name of the real data set
    [~, names_set] = LoadingDataset(15); 
    SimSkeleton = false(nNode, nNode);
    names = names_set(:, 1:nNode);
    for i = nFreeNode+1 : nNode
        n = 0;
        nParent = floor(nIndegree); % 向下取整
        tmp = nIndegree - nParent;
        if rand < tmp
            nParent = nParent + 1;
        end
        while n < nParent
            parent = randi(i-1); % 随着i的递增，节点的度数越高
            if ~SimSkeleton(i, parent)
                SimSkeleton(i, parent) = true;
                n = n + 1;
            end
        end
    end
    
end