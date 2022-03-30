function [Simskeleton] = GenSimSkeleton_largeout(nodes, Indegree, levels)
    idx = [1:nodes];
    idx_index = [];
    out_nodes = ceil(nodes*0.3);
    first_nodes = ceil(nodes*0.05);
    idx_index(1:first_nodes) = 1;
    differ = first_nodes - out_nodes;addffer = first_nodes + out_nodes;
    sigmod = 1; miu = floor((nodes - addffer)/levels);
    counts = 0;
    Simskeleton = zeros(nodes);
    flags_end = false;
    for level = 1:levels
        if counts < nodes - addffer
            level_nodes = round(sigmod*rand() + miu);
            for k = 1:level_nodes
                idx_index(end+1) = level+1;
            end
            counts = counts + level_nodes;
        else
            end_node = nodes - counts - first_nodes;
            max_n = max(idx_index);
            for kk = 1:end_node
                idx_index(end+1) = max_n+1;
            end
            flags_end = true;
        end
    end
    if ~flags_end
        end_node = nodes - counts - first_nodes;
        max_n = max(idx_index);
        for kk = 1:end_node
            idx_index(end+1) = max_n+1;
        end
        flags_end = true;
    end
    for p = 2:max(idx_index)
        list_nodes_par = find(idx_index<p);
        list_nodes = find(idx_index == p);
        for p1 = 1:length(list_nodes)
            n = 0;
            nParent = floor(Indegree);
            tmp = Indegree - nParent;
            if rand < tmp
                nParent = nParent + 1;
            end
            while n < nParent
                parent = randi(length(list_nodes_par)); % 随着i的递增，节点的度数越高
                if ~Simskeleton(p1, parent)
                    Simskeleton(p1, parent) = true;
                    n = n + 1;
                end
            end
        end
    end
end

