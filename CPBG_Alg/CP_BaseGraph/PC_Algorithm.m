function [PC_skeleton] = PC_Algorithm(data, idx, CI_ifo, alpha, threshold)
%PC_ALGORITHM_FINAL 
%   this function is traditional PC algorithm
%   to find causal edge in for subproblems
%   input data : the casual graph map in dataset
%          idx : nodes in graph     
    node = size(idx, 2);
    CSkeleton = CI_ifo;
    for i = 1:node-1
        for j = i+1:node
            flag = true;
            if CSkeleton(i, j) == 0
                continue;
            end
            [ind] = PaCoTest(data(:, i), data(:, j), [], alpha);
            if ind == false
                temp = (1:node);
                A_set = find(CSkeleton(i, :) == 0);
                B_set = find(CSkeleton(j, :) == 0);
                inter_AB = unique(intersect(A_set, B_set)); % both not ind node
                [~,D] = intersect(temp,inter_AB);
                temp(unique([i,j,D']))=[];
                conSepSet = temp;
                
                if ~isempty(conSepSet)
                    for l = 1:min(threshold, length(conSepSet))
                        if flag == false
                            break;
                        end
                        condPaAll = nchoosek(temp,l);
                        numCondPaAll = size(condPaAll,1);
                        for counts = 1:numCondPaAll
                            condPa = condPaAll(counts, :);
                            [ind] = PaCoTest(data(:, i), data(:, j), data(:, condPa), alpha);
                            if ind
                                CSkeleton(i, j) = 0;
                                CSkeleton(j, i) = 0;
                                flag = false;
                                break;
                            end
                        end
                    end
                end
            else
                CSkeleton(i, j) = 0;
                CSkeleton(j, i) = 0;
            end
        end
    end
    PC_skeleton = CSkeleton;
    
end

