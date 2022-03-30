function [rough_graph] = GetRoughGraph(CI_ifo)
    nodes = size(CI_ifo, 2);
    rough_graph = ones(nodes, nodes);
    for i = 1:nodes
        for j = 1:nodes
            if CI_ifo(i,j) == 1     
                rough_graph(i,j) = 0;
                rough_graph(j,i) = 0;
            end 
        end
    end
    rough_graph = rough_graph - eye(nodes);
end


