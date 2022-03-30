function [Choice_path, rough_graph] = FindPath(rough_graph, skeleton, CI_ifo_1, CI_ifo_2, node)
%FINDPATH Merge rough skeleton and find the path
%   This algorithm is used to find the two longest points in the graph and find their shortest distance
    flag_sparse = true;
    G = graph(rough_graph);
    Graph_sub = conncomp(G);
    counts = tabulate(Graph_sub);
    if size(counts, 1) > 1
        [counts_sort, counts_index] = sortrows(counts, 2, 'descend');
        if counts_sort(2, 3) < 10
            %% merging
            [rough_graph] = MerageGraph(rough_graph, CI_ifo_1, CI_ifo_2, skeleton);
        end
    end
    
    G = graph(rough_graph);
    Graph_sub = conncomp(G);
    counts = tabulate(Graph_sub);
%     if size(counts, 1) > 1 && counts_sort(2, 3) >= 10
%         Choice_path = [];
%         return
%     end
    %%
    for i = 1:node
        rough_graph(i, i) = 0;
    end
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
    
    Choice_path = shortestpath(G, X, Y);
end

