function [choice_path] = SepFindPath(rough_graph)
    G = graph(rough_graph);
    dis = distances(G);
    dis_index = isinf(dis);
    
    xxx = find(dis_index == 1);
    if ~isempty(xxx)
        dis(xxx) = 0;
    end
    [MA, IA] = max(dis);
    [Mx, My] = max(MA);
    X = IA(My);
    Y = My;
    
    choice_path = shortestpath(G, X, Y);
end

