function [CI_table] = GetCITable(rough_graph)
    nodes = size(rough_graph, 2);
    CI_table = ones(nodes, nodes);
    for i = 1:nodes
        for j = 1:nodes
            if rough_graph(i,j) == 0     
                CI_table(i,j) = 1;
                CI_table(j,i) = 1;
            else
                CI_table(i,j) = 0;
                CI_table(j,i) = 0;
            end
        end
    end
end

