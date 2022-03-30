function [X_names, Y_names] = FindTwoNodeG(G)
%FINDTWONODEG This is an equivalent algorithm, and the passed-in parameter is G
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
    node_names = table2cell(G.Nodes);
    X_names = node_names(X);
    Y_names = node_names(Y);
end

