function [X, Y] = FindTwoNode(rough_graph)
%FINDTWONODE The purpose of this algorithm is to find the "two furthest nodes" in the causal graph
%   Matlab's own graph function use.
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
end

